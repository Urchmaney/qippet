# frozen_string_literal: true

require "active_support"
require_relative "qippet/version"

# Main object for Qippet. This is the main entry point for
# the application.
module Qippet
  extend ActiveSupport::Autoload
  include ActiveSupport::Configurable

  config_accessor :font_family, :font_size
  # autoload :Xml, "qippet/extraction/xml"
  autoload :Extract
  autoload :Builder
  class Error < StandardError; end

  class << self
    def generate(path, output_file)
      yield config if block_given?

      extracted = Extract.from_file(path)
      node = Builder.build(extracted)

      if node.nil?
        puts "File does not contain a valid Qippet structure"
        return nil
      end

      result = node&.render

      result.write(output_file)
      output_file
    end
  end
end
