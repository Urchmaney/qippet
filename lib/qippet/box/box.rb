# frozen_string_literal: true

module Qippet
  # Abstract Class definiton for Box
  class Box
    attr_reader :node

    def children
      @children ||= []
    end

    def add_child(child)
      children << child
    end

    def render; end
  end
end
