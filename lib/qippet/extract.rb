# frozen_string_literal: true

module Qippet
  # Extract Class
  class Extract
    class << self
      def from_file(path)
        path = Pathname.new(Dir.pwd).join(path)
        read_file(path)
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
