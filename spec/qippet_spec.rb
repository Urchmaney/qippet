# frozen_string_literal: true

require "rmagick"
require "qippet"
require "qippet/builder/xml"

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

  it "should show error message if file structure is not valid" do
    allow(File).to receive(:read).and_return("file")
    output_file = "image.png"
    expect { Qippet.generate("", output_file) }.to output("File does not contain a valid Qippet structure\n").to_stdout
  end

  it "Should call extract from xml if file exists" do
    allow(Qippet::Builder::Xml).to receive(:build).and_call_original
    allow_any_instance_of(Magick::Image).to receive(:write)
    output_file = "image.png"
    file_path = "spec/assets/pop.xml"
    Qippet.generate(file_path, output_file)
    expect(Qippet::Builder::Xml).to have_received(:build)
  end
end

RSpec.describe "Qippet Reading File" do
  it "should return with value" do
    allow_any_instance_of(Magick::Image).to receive(:write)
    output_file = "image.png"
    file_path = "spec/assets/pop.xml"
    expect(Qippet.generate(file_path, output_file)).to eq(output_file)
  end
end
