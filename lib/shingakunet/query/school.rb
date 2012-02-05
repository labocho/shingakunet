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
      validate do
        if pref
          [pref].flatten.each do |e|
            unless e =~ /\A\d{2}\z/
              errors.add(:pref, :invalid)
            end
          end
        end
      end
      validate do
        if category
          [category].flatten.each do |e|
            unless e =~ /\A\d{4}\z/
              errors.add(:category, :invalid)
            end
          end
        end
      end
      validates :datum, inclusion: {in: ["world", "tokyo", :world, :tokyo], allow_nil: true}
      validates :order, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3, allow_nil: true}
      validates :start, numericality: {only_integer: true, greater_than: 0, allow_nil: true}
      validates :count, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, allow_nil: true}
      validates :format, inclusion: {in: ["xml", "json", "jsonp", :xml, :json, :jsonp], allow_nil: true}
    end
  end
end
