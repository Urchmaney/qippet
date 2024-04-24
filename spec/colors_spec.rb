# frozen_string_literal: true

require "qippet/colors"

RSpec.describe Qippet::Colors do
  it "should return color for color available" do
    shortname = "w"
    result = Qippet::Colors.get_color_by_shortname shortname
    expect(result).to eql "red"
  end

  it "should return black for color not available" do
    shortname = "jjj"
    result = Qippet::Colors.get_color_by_shortname shortname
    expect(result).to eql "black"
  end
end
