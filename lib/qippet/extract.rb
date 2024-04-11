# frozen_string_literal: true

module Qippet
  # Extraction Module
  module Extraction
    extend ActiveSupport::Autoload

    autoload :Xml

    class Extract
      include Xml
    end
  end
end
