# NAME

Acme::WebService::ChatworkApiV2 - チャットワークのAPI v2 に対応したラッパー

# SYNOPSIS

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

# DESCRIPTION

Acme::WebService::ChatworkApiV2 is Simple wrappers for Chatwork API.

# LICENSE

Copyright (C) sironekotoro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

sironekotoro <develop@sironekotoro.com>
