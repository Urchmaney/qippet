# frozen_string_literal: true

require "qippet/builder"
require "qippet/extract"
require "qippet/box/container_box"
# autoload :ContainerBox, "qippet/box/container_box"

RSpec.describe Qippet::Builder do
  it "should build qippet image" do
    data = Qippet::Builder.build
    expect(data).to eq("")
  end

  it "should build boxes" do
    file_path = "spec/assets/pop.xml"
    extracted_content = Qippet::Extraction::Extract.from_file(file_path)

    node = Qippet::Builder.setup_node extracted_content[:root]

    expect(node).to be_a Qippet::ContainerBox
    expect(node.children.length).to equal 2
    expect(node.children[0].children.length).to equal 1
  end
end
