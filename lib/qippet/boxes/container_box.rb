# frozen_string_literal: true

require_relative "./box"

module Qippet
  module Boxes
    # Container Class create from the "q" keyword
    class ContainerBox < Box
      ALLOWED_ATTRIBUTES = [].freeze
    end
  end
end
