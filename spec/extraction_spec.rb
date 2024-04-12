# frozen_string_literal: true

require "qippet/extract"

RSpec.describe Qippet::Extraction::Extract do
  it "should extract from xml" do
    extract_data = Qippet::Extraction::Extract.extract_from_xml_content("")
    expect(extract_data).to eq("")
  end

  # it "should return nil if reading that doesn't exist" do
  #   expect(Qippet::Extraction::Extract.read_file("data.rb")).to eq(nil)
  # end

  # it "should return file if it exists" do
  #   expect(Qippet::Extraction::Extract.read_file("data.rb")).to eq("file")
  # end
end
