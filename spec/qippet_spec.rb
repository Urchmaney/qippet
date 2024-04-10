# frozen_string_literal: true

RSpec.describe Qippet do
  it "has a version number" do
    expect(Qippet::VERSION).not_to be nil
  end

  it "configuration reflects when set with configure" do
    font_family = 'new_roman'
    Qippet.configure do |config|
      config.font_family = font_family
    end
    expect(font_family).to eq(Qippet.configuration.font_family)
  end
end
