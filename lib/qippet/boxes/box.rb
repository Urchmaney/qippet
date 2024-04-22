# frozen_string_literal: true

require "rmagick"
require "active_support/core_ext/enumerable"

module Qippet
  module Boxes
    # Abstract Class definiton for Box
    class Box
      attr_reader :node, :image

      PADDING = 20
      PADDING_X = 10

      def add_child(child)
        children << child
      end

      def render
        construct_box_image
      end

      def children
        @children ||= []
      end

      private

      def construct_box_image
        children_images = children.map(&:render)
        height = image_height(children_images)
        width = image_width(children_images)
        @image = Magick::Image.new(width, height)
        arrange_children_in_image(children_images)
      end

      def arrange_children_in_image(children_images)
        acc = 10
        children_images.each do |child_image|
          image.composite! child_image, PADDING_X, acc, Magick::OverCompositeOp
          acc += child_image.rows
        end
        image
      end

      def image_height(children_images)
        children_images.sum(&:columns) + PADDING
      end

      def image_width(children_images)
        (children_images.max { |a, b| a.rows <=> b.rows }&.rows || 0) + PADDING
      end

      # def get_image
      #   throw :undefined, "Box Abstract Method not defined"
      # end
    end
  end
end
