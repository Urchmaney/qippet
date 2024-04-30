# frozen_string_literal: true

module Github
  class << self
    def mock_response
      response = Object.new
      def response.body
        # rubocop:disable Layout/LineLength
        "{\"content\": \"IyBmcm96ZW5fc3RyaW5nX2xpdGVyYWw6IHRydWUKCm1vZHVsZSBSYWlscwog\\nICMgUmV0dXJucyB0aGUgY3VycmVudGx5IGxvYWRlZCB2ZXJzaW9uIG9mIFxS\\nYWlscyBhcyBhICtHZW06OlZlcnNpb24rLgogIGRlZiBzZWxmLmdlbV92ZXJz\\naW9uCiAgICBHZW06OlZlcnNpb24ubmV3IFZFUlNJT046OlNUUklORwogIGVu\\nZAoKICBtb2R1bGUgVkVSU0lPTgogICAgTUFKT1IgPSA3CiAgICBNSU5PUiA9\\nIDIKICAgIFRJTlkgID0gMAogICAgUFJFICAgPSAiYWxwaGEiCgogICAgU1RS\\nSU5HID0gW01BSk9SLCBNSU5PUiwgVElOWSwgUFJFXS5jb21wYWN0LmpvaW4o\\nIi4iKQogIGVuZAplbmQK\\n\"}"
        # rubocop:enable Layout/LineLength
      end
      response
    end
  end
end
