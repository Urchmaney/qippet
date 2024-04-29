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

  it "should return content from valid github path" do
    mock_response = Object.new
    def mock_response.body
      "{\"content\": \"IyBmcm96ZW5fc3RyaW5nX2xpdGVyYWw6IHRydWUKCm1vZHVsZSBSYWlscwog\\nICMgUmV0dXJucyB0aGUgY3VycmVudGx5IGxvYWRlZCB2ZXJzaW9uIG9mIFxS\\nYWlscyBhcyBhICtHZW06OlZlcnNpb24rLgogIGRlZiBzZWxmLmdlbV92ZXJz\\naW9uCiAgICBHZW06OlZlcnNpb24ubmV3IFZFUlNJT046OlNUUklORwogIGVu\\nZAoKICBtb2R1bGUgVkVSU0lPTgogICAgTUFKT1IgPSA3CiAgICBNSU5PUiA9\\nIDIKICAgIFRJTlkgID0gMAogICAgUFJFICAgPSAiYWxwaGEiCgogICAgU1RS\\nSU5HID0gW01BSk9SLCBNSU5PUiwgVElOWSwgUFJFXS5jb21wYWN0LmpvaW4o\\nIi4iKQogIGVuZAplbmQK\\n\"}"
    end

    allow(Net::HTTP).to receive(:get_response).and_return(mock_response)
    github_path = "rails/rails/contents/version.rb"
    response = Qippet::Extract.from_github(github_path)
    expect(response).not_to be nil
  end
end
