# frozen_string_literal: true

require "qippet/builder"

RSpec.describe Qippet::Builder do
  it "should build qippet image" do
    data = Qippet::Builder.build
    expect(data).to eq("")
  end

  it "should be able to call specific builder" do
    expect { Qippet::Builder.build_from_xml_node }.to raise_error(NoMethodError)
  end
end
