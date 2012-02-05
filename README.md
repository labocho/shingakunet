# shingakunet

リクルート進学ネットの API を Ruby から利用するためのライブラリです。
リクルート Web サービスの API キーが必要です。

クエリのパラメータ、レスポンスの構造は下記で参照できます。

http://webservice.recruit.co.jp/shingaku/reference-v2.html

## Instllation

    git clone git://github.com/labocho/shingakunet.git
    cd shingakunet
    bundle install
    rake install

### Uninstallation

    gem uninstall shingakunet

## Usage

    require "shingakunet"
    Shingakunet.config "xxxxxxxxxxxxxxxx" # Your API Key
    query = Shingakunet::Query::School.new(pref: "13")
    response = query.get
    response.success? # true
    response.raw # XML string
    response.document # Nokogiri::XML::Document
    response.to_hash # Hash
    response.to_yaml # YAML string

## Contributing to shingakunet
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 labocho. See LICENSE.txt for
further details.

