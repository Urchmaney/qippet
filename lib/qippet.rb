# frozen_string_literal: true

require_relative "qippet/version"

# Main object for Qippet. This is the main entry point for
# the application.
module Qippet
  class Error < StandardError; end

  # Configuration class Object
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

    def configure
      yield configuration
    end
  end
end
