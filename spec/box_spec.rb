# frozen_string_literal: true

require "qippet/boxes/container_box"
require "qippet/boxes/code_box"
require "support/github"

RSpec.describe Qippet::Boxes do
  it "should call children render when render is called" do
    boxes = [Qippet::Boxes::ContainerBox.new, Qippet::Boxes::ContainerBox.new, Qippet::Boxes::ContainerBox.new]
    boxes[0].add_child boxes[1]
    boxes[0].add_child boxes[2]

    boxes.each do |box|
      allow(box).to receive(:render).and_call_original
      expect(box).to receive(:render).once
    end
    boxes[0].render
  end

  it "should setup attributes" do
    code_box = Qippet::Boxes::CodeBox.new
    expect { code_box.source }.not_to raise_error
  end

  it "should accept allowed attribute value" do
    code_box = Qippet::Boxes::CodeBox.new
    code_box.add_attributes([[:source, "github"]])
    expect(code_box.source).to equal("github")
  end

  it "should not accept unallowed attribute" do
    code_box = Qippet::Boxes::CodeBox.new
    code_box.add_attributes([[:nsource, "github"]])
    expect(code_box.source).to be_nil
  end
end

RSpec.describe Qippet::Boxes::CodeBox do
  it "should extract code from file" do
    code_box = Qippet::Boxes::CodeBox.new
    code_box.add_attributes([[:path, "./Rakefile"]])
    allow(code_box).to receive(:fetch_code_from_source).and_call_original
    code_box.render
    expect(code_box).to have_received(:fetch_code_from_source)
  end

  it "should extract code from github" do
    allow(Net::HTTP).to receive(:get_response).and_return(Github.mock_response)
    code_box = Qippet::Boxes::CodeBox.new
    allow(code_box).to receive(:fetch_code_from_source).and_call_original
    code_box.add_attributes([[:source, "github"], [:path, ""]])
    code_box.render
    expect(code_box).to have_received(:fetch_code_from_source)
  end
end

RSpec.describe "Qippet::Boxes::CodeBox Attribute" do
  it "should throw error with invalid range attribute" do
    code_box = Qippet::Boxes::CodeBox.new
    code_box.add_attributes([[:path, "./Rakefile"], [:range, "f"]])
    expect { code_box.render }.to raise_error(ArgumentError)
    code_box.add_attributes([[:path, "./Rakefile"], [:range, "2,f"]])
    expect { code_box.render }.to raise_error(ArgumentError)
    code_box.add_attributes([[:path, "./Rakefile"], [:range, "0 0"]])
    expect { code_box.render }.to raise_error(ArgumentError)
  end

  it "should not throw error with valid range attribute" do
    code_box = Qippet::Boxes::CodeBox.new
    code_box.add_attributes([[:path, "./Rakefile"], [:range, "3, 6"]])
    expect { code_box.render }.not_to raise_error
  end
end
