module Shingakunet
  module Query
    class School < Base
      include Paginatable

      self.keys = %w(code area pref category keyword subject work license datum order start count format).freeze
      self.base_url = "http://webservice.recruit.co.jp/shingaku/school/v2/".freeze

      validates :key, presence: true
      validate do
        unless [code, area, pref, category, keyword, subject, work, license].any?{|v| v.presence}
          errors.add(:code, ", area, pref, category, keyword, subject, work, and license are blank")
        end
      end

      # 複数指定の validation ができないため保留
      # validates :pref, format: {with: /\A\d{2}\z/, allow_nil: true}
      # validates :category, format: {with: /\A\d{4}\z/, allow_nil: true}
      validates :datum, inclusion: {in: ["world", "tokyo", :world, :tokyo], allow_nil: true}
      validates :order, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3, allow_nil: true}
      validates :start, numericality: {only_integer: true, greater_than: 0, allow_nil: true}
      validates :count, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, allow_nil: true}
      validates :format, inclusion: {in: ["xml", "json", "jsonp", :xml, :json, :jsonp], allow_nil: true}
    end
  end
end
