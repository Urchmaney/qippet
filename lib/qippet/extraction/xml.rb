# frozen_string_literal: true

module Qippet
  module Extraction
    # XML Extractor class
    module Xml
      extend ActiveSupport::Concern

      # Class Method
      module ClassMethods
        def extract_from_xml_content(content = "")
          content
        end
      end
    end
  end
end
