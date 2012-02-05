require "uri"
require "open-uri"
require "active_model"
module Shingakunet
  module Query
    class Base
      include ActiveModel::Validations
      attr_reader :parameters

      def self.keys=(keys)
        @keys = (["key"] | keys).freeze
        define_parameter_accessors
      end

      def self.base_url=(url)
        @base_url = URI.parse url
      end

      def self.keys
        @keys
      end

      def self.base_url
        @base_url
      end

      def self.paginatable?
        ancestors.include?(Paginatable)
      end

      def self.define_parameter_accessors
        define_method :[] do |key|
          parameters[key]
        end

        define_method :[]= do |key, value|
          parameters[key] = value
        end

        @keys.each do |k|
          define_method k do
            self[k]
          end
          define_method "#{k}=" do |val|
            self[k] = val
          end
        end
      end

      def initialize(parameters = {})
        @parameters = parameters.dup.inject({}){|result, (k, v)| result[k.to_s] = v; result}
        @parameters["key"] ||= Shingakunet.api_key
      end

      def base_url
        self.class.base_url
      end

      def keys
        self.class.keys
      end

      def paginatable?
        self.class.paginatable?
      end

      def get(format = :object)
        return false unless valid?

        raw = open(url) do |f|
          f.read
        end

        Shingakunet::Response.new(raw)
      end

      def url
        url = base_url.dup
        url.query = URI.encode_www_form(normalized_parameters)
        url
      end

      private
      def normalized_parameters
        parameters.inject({}) do |result, (k, v)|
          v = case v
          when Array
            v.map{|e| e.to_s}.join(",")
          else
            v.to_s
          end.strip

          next result if v == ""
          result[k] = v
          result
        end
      end
    end
  end
end
