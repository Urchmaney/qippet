# frozen_string_literal: true

require "nokogiri"

module Qippet
  module Extraction
    # XML Extractor class
    module Xml
      extend ActiveSupport::Concern

      # Class Method
      module ClassMethods
        def extract_from_xml_content(content = "")
          return "" if content.empty?

          parsed_data = Nokogiri::XML.parse(content)
          parsed_data.deconstruct_keys([:root])
        end
      end
    end
  end
end
