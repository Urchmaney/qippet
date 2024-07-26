# frozen_string_literal: true

require_relative "./builder/xml"

# Qippet
module Qippet
  # Builder Class
  module Builder
    class << self
      def build(content)
        Xml.build(content)
      end
    end
  end
end
