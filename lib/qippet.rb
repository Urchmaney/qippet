# frozen_string_literal: true

require_relative "qippet/version"

module Qippet
  class Error < StandardError; end
  class Configuration
    attr_accessor :font_family

    def initialize
      @font_family = "helvetica"
    end

  end

  class << self
    @configuration = nil

    def configuration
      @configuration ||= Configuration.new
    end

    def configure(&block)
      yield configuration
    end
  end
end
