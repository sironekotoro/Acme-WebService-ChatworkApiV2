package Acme::WebService::ChatworkApiV2;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Encode qw/encode_utf8/;
use Function::Parameters;
use HTTP::Tiny;
use JSON::PP 4.05 qw/decode_json/;
use Mouse v2.5.10;
use URI;

has token => (
    is  => 'ro',
    isa => 'Str',
);

has http => (
    is      => 'rw',
    isa     => 'HTTP::Tiny',
    builder => sub {
        my $self = shift;
        HTTP::Tiny->new(
            default_headers => { "X-ChatWorkToken" => $self->token } );
    }
);

method api( :$method, :$url, :$opt = {} ) {

    my $response;

    my $uri = URI->new($url);

    if ( $method eq 'get' ) {

        my $opt_string
            = keys %{$opt} > 0 ? opt_string_url_encode($opt) : undef;

        $uri->query_form($opt);
        print $uri;

        $response = $self->http->get($uri);
    }
    elsif ( $method =~ /post|put|delete/ ) {

        my $opt_string
            = keys %{$opt} > 0 ? opt_string_url_encode($opt) : undef;

        $response = $self->http->$method(
            $uri,
            {   headers =>
                    { 'Content-Type' => 'application/x-www-form-urlencoded' },
                content => $opt_string
            }
        );
    }

    my $encoded_content = encode_utf8( $response->{content} );

    return $encoded_content ? decode_json($encoded_content) : $response;

}

fun opt_string_url_encode($opt) {

    my @array = ();
    while ( my ( $key, $value ) = each %{$opt} ) {

        if ( ( ref $value ) eq 'ARRAY' ) {

            # valueが配列リファレンスの場合、カンマ区切りの文字列に置き換える
            $value = join ',', @{$value};
        }
        push @array, "$key=$value";
    }

    my $str = join "&", @array;

    return $str;
}

1;

__END__

=encoding utf-8

=head1 NAME

Acme::WebService::ChatworkApiV2 - チャットワークのAPI v2 に対応したラッパー

=head1 SYNOPSIS

    use Acme::WebService::ChatworkApiV2;
    use Data::Dumper;

    my $cw = Acme::WebService::ChatworkApiV2->new(
        token => "YOUR_API_TOKEN" );

    # 自身の情報を取得（https://developer.chatwork.com/ja/endpoint_me.html）
    my $res = $cw->api(
        method => 'get',
        url    => 'https://api.chatwork.com/v2/my/status',
        opt    => {}
    );
    print Dumper $res;


    # room の情報を取得（https://developer.chatwork.com/ja/endpoint_rooms.html#GET-rooms-room_id）
    my $res = $cw->api(
        method => 'get',
        url    => 'https://api.chatwork.com/v2/rooms',
        opt    => {}
    );
    print Dumper $res;

    # room を作成する（https://developer.chatwork.com/ja/endpoint_rooms.html#POST-rooms）
    my $res = $cw->api(
        method => 'post',
        url    => 'https://api.chatwork.com/v2/rooms',
        opt    => { members_admin_ids => [123456789], name => 'TEST POST' },
    );

    # 添付ファイルのダウンロードリンクを取得する（https://developer.chatwork.com/ja/endpoint_rooms.html#GET-rooms-room_id-files-file_id）
    my $res = $cw->api(
        method => 'get',
        url =>
            "https://api.chatwork.com/v2/rooms/$room_id/files/$file_id",
        opt => { create_download_url => 1 },
    );


=head1 DESCRIPTION

Acme::WebService::ChatworkApiV2 is Simple wrappers for Chatwork API.

=head1 LICENSE

Copyright (C) sironekotoro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

sironekotoro E<lt>develop@sironekotoro.comE<gt>

=cut

