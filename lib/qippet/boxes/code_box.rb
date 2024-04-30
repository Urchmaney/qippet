# frozen_string_literal: true

require_relative "./box"
require "qippet/extract"
require "qippet/colors"
require "rouge"

module Qippet
  module Boxes
    # Box for creating code
    class CodeBox < Box
      # Class to formate code tokens
      class BareColorFormatter < Rouge::Formatter
        def stream(tokens)
          token_lines(tokens).with_index do |line_tokens, lineno|
            line_tokens_with_color = line_tokens.map do |token|
              token_color = Colors.get_color_by_shortname(token[0].shortname)
              [token_color, *token]
            end

            yield line_tokens_with_color, lineno
          end
        end
      end

      attr_reader :code_content, :code_lines, :show_line, :writer, :tokenizer, :formatter

      ALLOWED_ATTRIBUTES = %i[source path].freeze

      TAB_SPACE = 20
      CODE_LINE_HEIGHT = 19
      CODE_CHAR_WIDTH = 8

      def initialize
        super
        @show_line = false
      end

      def add_child(*)
        throw :no_children_for_node, "Code Box cannot contain chidren"
      end

      def render
        fetch_code_from_file
        return nil if code_content.nil?

        setup_syntax_highliter
        setup_writer
        super
        write_code_on_image
      end

      private

      def fetch_code_from_file
        @code_content = source == "github" ? Extract.from_github(path) : Extract.from_file(path)
        return nil if code_content.nil?

        @code_lines = code_content.split("\n")
      end

      def write_code_on_image
        @row_position = PADDING + CODE_LINE_HEIGHT

        formatter.format(tokenizer.lex(code_content)) do |line, index|
          @column_position = PADDING
          add_line_number(index + 1) if show_line

          line.each do |token_with_color|
            write_token(token_with_color)
          end
          @row_position += CODE_LINE_HEIGHT
        end
        image
      end

      def write_token(token_with_color)
        color, token_type, token = token_with_color
        token.prepend("\\") if token_type.shortname.blank?

        escape_special_characters(token)
        token_width = writer.get_type_metrics(token).width

        writer.annotate(image, 0, 0, @column_position, @row_position, token) { |opt| opt.fill = color }
        @column_position += token_width
      end

      def setup_syntax_highliter
        @tokenizer = Rouge::Lexers::Ruby.new
        @formatter = BareColorFormatter.new
      end

      def escape_special_characters(str)
        str.gsub!(/%/, "%" => "%%")
      end

      def add_line_number(number)
        writer.annotate(image, 0, 0, @column_position, @row_position, number.to_s) { |opt| opt.fill = "black" }
        @column_position += TAB_SPACE
      end

      def add_line_indentation(line)
        line.chars.each do |c|
          break if c != " "

          @row_position += CODE_CHAR_WIDTH
        end
      end

      def setup_writer
        @writer = Magick::Draw.new
        @writer.font_family = "helvetica"
        @writer.pointsize = 15
      end

      def image_height(*)
        (code_lines.length * CODE_LINE_HEIGHT) + (2 * PADDING)
      end

      def image_width(*)
        code_lines.map { |line| line.blank? ? 0 : writer.get_type_metrics(line).width }.max + (2 * PADDING)
      end
    end
  end
end
