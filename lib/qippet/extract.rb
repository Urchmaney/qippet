# frozen_string_literal: true

require "uri"
require "net/http"
require "base64"
require "json"
require 'pathname'

module Qippet
  # Extract Class
  class Extract
    class << self
      GITHUB_BASE_API_URL = "https://api.github.com/repos/"

      def from_file(path)
        path = Pathname.new(Dir.pwd).join(path)
        read_file(path)
      end

      def from_github(path = "rails/rails/contents/version.rb")
        url = URI("#{GITHUB_BASE_API_URL}#{path}")
        response = Net::HTTP.get_response(url)
        response = JSON.parse(response.body)
        Base64.decode64(response["content"])
      rescue StandardError
        nil
      end

      private

      def read_file(path)
        File.read(path)
      rescue Errno::ENOENT, Errno::EISDIR
        nil
      end
    end
  end
end
