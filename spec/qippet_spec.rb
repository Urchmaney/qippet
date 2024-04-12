# frozen_string_literal: true

require "qippet"

RSpec.describe Qippet do
  it "has a version number" do
    expect(Qippet::VERSION).not_to be nil
  end

  it "configuration reflects when set with configure" do
    font_family = "new_roman"
    Qippet.configure do |config|
      config.font_family = font_family
    end
    expect(Qippet.configuration.font_family).to eq(font_family)
  end

  it "should generate output file" do
    allow(File).to receive(:read).and_return("file")
    output_file = "image.png"
    result = Qippet.generate("", output_file)
    expect(result).to eq(output_file)
  end

  it "should output error if file does not exist" do
    expect { Qippet.generate("random.rs", "") }.to output("Error: File not found").to_stdout
  end
end
