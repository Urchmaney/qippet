# frozen_string_literal: true

require "active_support"
require_relative "qippet/version"

# Main object for Qippet. This is the main entry point for
# the application.
module Qippet
  extend ActiveSupport::Autoload

  # autoload :Xml, "qippet/extraction/xml"
  autoload :Extract
  class Error < StandardError; end

  # Configuration class Object
  class Configuration
    attr_accessor :font_family

    def initialize
      @font_family = "helvetica"
      @font_size = 15
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

    def generate(path, output_file)
      yield configuration if block_given?

      extracted = Extraction::Extract.from_file(path)
      node = Builder.setup_node(extracted[:root])
      puts "File does not contain a valid Qippet structure" if node.nil?

      node&.render
      # result.write(output_file)
      output_file
    end
  end
end
