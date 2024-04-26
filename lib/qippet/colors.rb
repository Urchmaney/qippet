# frozen_string_literal: true

module Qippet
  # Module contains all colors for code
  module Colors
    DEFAULT_COLORS = {
      w: "red",
      o: "black",
      nb: "blue",
      c1: "gray",
      s2: "#FF7F50",
      no: "#50D0FF"
    }.freeze

    def self.get_color_by_shortname(shortname)
      DEFAULT_COLORS.fetch(shortname.to_sym, "black")
    end
  end
end
