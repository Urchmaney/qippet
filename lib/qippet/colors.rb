# frozen_string_literal: true

module Qippet
  # Module contains all colors for code
  module Colors
    DEFAULT_COLORS = {
      w: "red"
    }.freeze

    def self.get_color_by_shortname(shortname)
      DEFAULT_COLORS.fetch(shortname.to_sym, "black")
    end
  end
end
