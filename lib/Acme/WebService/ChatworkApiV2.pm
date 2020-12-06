package Acme::WebService::ChatworkApiV2;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use HTTP::Tiny;
use JSON::PP 4.05 qw/decode_json/;
use Mouse v2.5.10;
use URI 5.05;

has token => (
    is  => 'rw',
    isa => 'Str',
);

sub rooms {
    my $self = shift;

    my $ht = HTTP::Tiny->new(
        default_headers => { "X-ChatWorkToken" => $self->token } );

    my $url = URI->new("https://api.chatwork.com/v2/rooms");
    my $res = $ht->get($url);

    if ( $res->{success} ) {
        return decode_json( $res->{content} );
    }
    else {
        die "$res->{code}:";
    }

}

sub rooms_files {
    my $self = shift;
    my $argv = shift;

    my $ht = HTTP::Tiny->new(
        default_headers => { "X-ChatWorkToken" => $self->token } );
    my $url
        = URI->new(
        "https://api.chatwork.com/v2/rooms/$argv->{rooms_id}/files/$argv->{file_id}?create_download_url=1"
        );

    my $res = $ht->get($url);

    if ( $res->{success} ) {
        return decode_json( $res->{content} );
    }
    else {
        die "$res->{code}:";
    }

}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::WebService::ChatworkApiV2 - チャットワークのAPI v2 に対応したラッパー

=head1 SYNOPSIS

    use Acme::WebService::ChatworkApiV2;

    my $cw = Acme::WebService::ChatworkApiV2->new(
        token => "YOUR_API_TOKEN" );

    # room の情報を取得
    my $rooms = $cw->rooms();
    print Dumper $rooms;    # 参加している room の情報

    # 添付ファイルのダウンロードリンクを取得する
    my $file_info = $cw->rooms_files(
        {   rooms_id => '',
            file_id  => '',
        }
    );

    my $download_url = $file_info->{download_url}; # 30 秒間有効なダウンロードリンク


=head1 DESCRIPTION

Acme::WebService::ChatworkApiV2 is ...

=head1 LICENSE

Copyright (C) sironekotoro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

sironekotoro E<lt>develop@sironekotoro.comE<gt>

=cut

