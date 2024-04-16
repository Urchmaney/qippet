# frozen_string_literal: true

require "qippet/box/container_box"

RSpec.describe Qippet::Box do
  it "should call children render when render is called" do
    boxes = [Qippet::ContainerBox.new, Qippet::ContainerBox.new, Qippet::ContainerBox.new]
    boxes[0].add_child boxes[1]
    boxes[0].add_child boxes[2]

    boxes.each do |box|
      allow(box).to receive(:render).and_call_original
      expect(box).to receive(:render).once
    end
    boxes[0].render
  end
end
