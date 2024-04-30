# frozen_string_literal: true

require "qippet/extract"
require "support/github"

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
    allow(Net::HTTP).to receive(:get_response).and_return(Github.mock_response)
    github_path = "rails/rails/contents/version.rb"
    response = Qippet::Extract.from_github(github_path)
    expect(response).not_to be nil
  end
end
