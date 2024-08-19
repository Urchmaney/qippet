# frozen_string_literal: true

require_relative "qippet/version"
require_relative "./qippet/builder"
require_relative "./qippet/extract"
require_relative "./qippet/config"

# Main object for Qippet. This is the main entry point for
# the application.
module Qippet
  class Error < StandardError; end
  extend Qippet::Config
  class << self
    def generate(layout_path = nil, output_path = "output.png")
      yield config if block_given?
      
      extracted = Extract.from_file(layout_path)
      node = Builder.build(extracted)

      if node.nil?
        puts "File does not contain a valid Qippet structure"
        return nil
      end

      result = node&.render


      result.write(output_path)
      output_path
    end
  end
end
