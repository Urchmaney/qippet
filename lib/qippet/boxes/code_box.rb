# frozen_string_literal: true

require_relative "./box"

module Qippet
  module Boxes
    class LineBox < Box
    end

    # Box for creating code
    class CodeBox < Box
      def fetch_code
        fetch_code_from_file
      end

      # def fetch_code_from_file
      #   code_file_path = "/code/check.rb"
      # end
    end
  end
end
