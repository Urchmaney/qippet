module Qippet
  module Extraction
    extend ActiveSupport::Autoload

    autoload :Xml

    class Extract
      include Xml
    end
  end
end