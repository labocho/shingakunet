module Shingakunet
  class Response
    attr_reader :raw

    def initialize(raw)
      @raw = raw
    end

    def document
      require "nokogiri" unless defined? Nokogiri
      @document || (@document = Nokogiri.parse(raw))
    end

    def to_hash
      require "active_support/core_ext/hash" unless Hash.respond_to?(:from_xml)
      @hash || (@hash = Hash.from_xml(raw).freeze)
    end

    def to_yaml
      @yaml || (@yaml = to_hash.to_yaml.freeze)
    end

    def api_version
      @api_version || (@api_version = document.search("api_version").first.text)
    end

    def results_available
      return @results_available if @results_available
      element = document.search("results_available").first
      @results_available = element && element.text.to_i
    end

    def results_returned
      return @results_returned if @results_returned
      element = document.search("results_returned").first
      @results_returned = element && element.text.to_i
    end

    def results_start
      return @results_start if @results_start
      element = document.search("results_start").first
      @results_start = element && element.text.to_i
    end

    def next_start
      return unless results_start && results_returned && results_available
      start = results_start + results_returned
      start <= results_available ? start : nil
    end

    def error
      return @error if @error
      element = document.search("error message").first
      @error = element && element.text
    end

    def success?
      !error
    end

    def next?
      !!next_start
    end
  end
end
