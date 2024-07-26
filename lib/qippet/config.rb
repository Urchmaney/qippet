# frozen_string_literal: true

module Qippet
  # Configuration module for Qippet
  module Config
    # Configuration Instance
    class Configuration
      attr_accessor :font_family
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end
  end
end
