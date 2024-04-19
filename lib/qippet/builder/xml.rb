# frozen_string_literal: true

require "nokogiri"
require "qippet/boxes/container_box"
require "qippet/boxes/text_box"
require "qippet/boxes/code_box"

module Qippet
  module Builder
    # Builder from XML content to box
    module Xml
      extend ActiveSupport::Autoload
      extend self

      def build(content = "")
        structured_content = create_structure_from_xml_content(content)
        return nil if structured_content.nil?

        setup_node(structured_content[:root])
      end

      private

      def create_structure_from_xml_content(content)
        return nil if content.empty?

        parsed_data = Nokogiri::XML.parse(content)
        parsed_data.deconstruct_keys([:root])
      end

      def setup_node(node)
        return nil unless node.presence

        node.content.strip!
        node_box = get_node_box(node.name.presence)
        return node_box if node.children.empty?

        node.children.each do |child|
          box = setup_node(child)
          node_box.add_child box if box.present?
        end

        node_box
      end

      def get_node_box(node_name)
        case node_name
        when "q"
          Qippet::Boxes::ContainerBox.new
        when "code"
          Qippet::Boxes::CodeBox.new
        when "text"
          Qippet::Boxes::TextBox.new
        else
          throw :unrecognize_structure, "Structure contains unrecognize element."
        end
      end
    end
  end
end
