# frozen_string_literal: true

require_relative "lib/hotwire_datatables/version"

Gem::Specification.new do |spec|
  spec.name = "hotwire_datatables"
  spec.version = HotwireDatatables::VERSION
  spec.authors = ["Marcus Ilgner"]
  spec.email = ["mail@marcusilgner.com"]

  spec.summary = "A full-stack datatables library based on Hotwire."
  spec.description = <<~DESCRIPTION
    DRY patterns for when you need more than just one datatable in your app.
    Includes sorting, filtering and patterns for live-updates to your data,
    as well as default styles and formatting for common use-cases.
  DESCRIPTION

  spec.homepage = "https://github.com/milgner/hotwire_datatables"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/milgner/hotwire_datatables.git"
  spec.metadata["changelog_uri"] = "https://github.com/milgner/hotwire_datatables/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "turbo-rails", ">= 1.1.1"

  spec.add_development_dependency "rails", ">= 7.0"
  spec.add_development_dependency "rspec-rails", ">= 6.0.0.rc1"
  spec.add_development_dependency "sprockets-rails"
  spec.add_development_dependency "sqlite3"
end
