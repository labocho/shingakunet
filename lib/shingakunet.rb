module Shingakunet
  autoload :Query, "shingakunet/query"
  autoload :Response, "shingakunet/response"
  def self.config(api_key)
    @api_key = api_key
  end

  def self.api_key
    @api_key
  end
end
