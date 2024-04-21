# frozen_string_literal: true

require_relative "./box"
require "qippet/extract"

module Qippet
  module Boxes
    # Box for creating code
    class CodeBox < Box
      attr_reader :code_lines, :show_line, :writer

      CODE_LINE_HEIGHT = 25
      CODE_TAB = 20

      def initialize
        super
        @show_line = true
      end

      def add_child(*)
        throw :no_children_for_node, "Code Box cannot contain chidren"
      end

      def fetch_code_from_file
        code_file_path = "./Rakefile"
        code_content = Extract.from_file(code_file_path)
        return nil if code_content.nil?

        @code_lines = code_content.split("\n")
      end

      def render
        fetch_code_from_file
        return nil if code_lines.nil?

        setup_writer
        write_code_on_image super
      end

      private

      def write_code_on_image(image)
        code_lines.each_with_index do |line, index|
          @line_tab = PADDING_X
          add_line_number(index + 1) if show_line

          add_line_indentation line
          writer.annotate(image, 0, 0, @line_tab, CODE_LINE_HEIGHT * (index + 1), line)
        end
        image
      end

      def add_line_number(number)
        writer.annotate(image, 0, 0, @line_tab, CODE_LINE_HEIGHT * number, number.to_s)
        @line_tab += 40
      end

      def add_line_indentation(line)
        line.chars.each do |c|
          break if c != " "

          @line_tab += 10
        end
      end

      def setup_writer
        @writer = Magick::Draw.new
        @writer.font_family = "helvetica"
        @writer.pointsize = 15
      end

      def image_height(*)
        (code_lines.length * CODE_LINE_HEIGHT) + PADDING
      end

      def image_width(*)
        ((code_lines.max { |a, b| a.length <=> b.length }&.length || 0) * 10) + PADDING
      end
    end
  end
end
