# frozen_string_literal: true

require "qippet/extract"

RSpec.describe Qippet::Extract do
  it "should return nil if reading that doesn't exist" do
    expect(Qippet::Extract.from_file("data.rb")).to eq(nil)
    expect(Qippet::Extract.from_file("")).to eq(nil)
  end

  it "should return file if it exists" do
    file_path = "spec/assets/pop.xml"
    expect(Qippet::Extract.from_file(file_path)).not_to be nil
  end
end
