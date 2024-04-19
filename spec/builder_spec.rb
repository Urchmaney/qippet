# frozen_string_literal: true

require "qippet/builder"
require "qippet/boxes/container_box"
# require "qippet/boxes/text_box"

RSpec.describe Qippet::Builder do
  it "should build box from xml string" do
    content = "<q> Palma </q>"
    box = Qippet::Builder.build content
    expect(box).to be_a Qippet::Boxes::ContainerBox
    expect(box.children.length).to equal 1
  end

  # it "should build boxes" do
  #   file_path = "spec/assets/pop.xml"
  #   extracted_content = Qippet::Extraction::Extract.from_file(file_path)

  #   node = Qippet::Builder.setup_node extracted_content[:root]

  #   expect(node).to be_a Qippet::ContainerBox
  #   expect(node.children.length).to equal 2
  #   expect(node.children[0].children.length).to equal 1
  # end
end
