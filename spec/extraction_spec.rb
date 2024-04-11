
RSpec.describe  Qippet::Extraction::Extract do
  it "should extract from xml" do
    extract_data = Qippet::Extraction::Extract.extract_from_xml
    expect(extract_data).to eq("")
  end

end