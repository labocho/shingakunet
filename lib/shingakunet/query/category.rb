module Shingakunet
  module Query
    class Category < Base
      self.keys = %w(format).freeze
      self.base_url = "http://webservice.recruit.co.jp/shingaku/category/v2/".freeze
    end
  end
end

