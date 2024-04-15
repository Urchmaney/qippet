# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/object/blank"

# Qippet
module Qippet
  extend ActiveSupport::Autoload

  autoload :ContainerBox, "qippet/box/container_box"
  autoload :TextBox, "qippet/box/text_box"
  autoload :CodeBox, "qippet/box/code_box"

  # Builder Class
  class Builder
    class << self
      def build
        build_from_xml_node
      end

      def setup_node(node)
        return unless node.content.strip.present?

        node_box = get_node_box(node.name.presence)
        return node_box if node.children.empty?

        node.children.each do |child|
          box = setup_node(child)
          node_box.add_child box if box.present?
        end

        node_box
      end

      private

      def get_node_box(node_name)
        case node_name
        when "q"
          ContainerBox.new
        when "code"
          CodeBox.new
        when "text"
          TextBox.new
        else
          throw :unrecognize_structure, "Structure contains unrecognize element."
        end
      end

      def build_from_xml_node
        ""
      end
    end
  end
end
