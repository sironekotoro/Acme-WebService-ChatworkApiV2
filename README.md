# NAME

Acme::WebService::ChatworkApiV2 - チャットワークのAPI v2 に対応したラッパー

# SYNOPSIS

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

# DESCRIPTION

Acme::WebService::ChatworkApiV2 is ...

# LICENSE

Copyright (C) sironekotoro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

sironekotoro <develop@sironekotoro.com>
