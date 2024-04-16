# frozen_string_literal: true

module Qippet
  # Extraction Module
  module Extraction
    extend ActiveSupport::Autoload

    autoload :Xml

    # Extract Class
    class Extract
      include Xml

      class << self
        def from_file(path)
          path = Pathname.new(Dir.pwd).join(path)
          content = read_file(path)
          return nil if content.nil?

          extract_from_xml_content(content)
        end

        private

        def read_file(path)
          File.read(path)
        end
      end
    end
  end
end
