module Shingakunet
  module Query
    class Prefecture < Base
      self.keys = %w(code area format).freeze
      self.base_url = "http://webservice.recruit.co.jp/shingaku/pref/v2/".freeze
    end
  end
end
