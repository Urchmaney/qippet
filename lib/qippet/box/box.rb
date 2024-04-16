# frozen_string_literal: true

module Qippet
  # Abstract Class definiton for Box
  class Box
    attr_reader :node

    def add_child(child)
      children << child
    end

    def render
      children.each(&:render)
    end

    def children
      @children ||= []
    end
  end
end
