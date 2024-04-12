# frozen_string_literal: true

require_relative "lib/qippet/version"

Gem::Specification.new do |spec|
  spec.name = "qippet"
  spec.version = Qippet::VERSION
  spec.author = "Unegbu Kingsley"
  spec.email = "kingsobino@gmail.com"

  spec.summary = "Code Snippet Imagery."
  spec.description = "Create beautify code snippet image."
  spec.homepage = "https://github.com/Urchmaney/qippet"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Urchmaney/qippet"
  spec.metadata["changelog_uri"] = "https://github.com/Urchmaney/qippet"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rmagick", "~> 5.5"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
