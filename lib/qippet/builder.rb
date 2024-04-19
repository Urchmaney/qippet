# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/object/blank"

# Qippet
module Qippet
  extend ActiveSupport::Autoload

  # Builder Class
  module Builder
    extend ActiveSupport::Autoload

    autoload :Xml

    class << self
      def build(content)
        Xml.build(content)
      end
    end
  end
end
