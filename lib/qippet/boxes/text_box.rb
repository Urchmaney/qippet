# frozen_string_literal: true

require_relative "./box"

module Qippet
  module Boxes
    # Text box created from the "text" keyword
    class TextBox < Box
      ALLOWED_ATTRIBUTES = [].freeze
    end
  end
end
