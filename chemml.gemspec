# frozen_string_literal: true

require_relative "lib/chemml/version"

Gem::Specification.new do |spec|
  spec.name          = "chemml"
  spec.version       = Chemml::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "ChemML — Chemical Markup Language (CML) for Ruby."
  spec.description   = "ChemML provides a lutaml-model-based Ruby object model for the " \
                       "Chemical Markup Language (CML). Parse, manipulate, and serialize " \
                       "CML XML with full round-trip fidelity. Designed as a sibling model " \
                       "to other chemistry model layers (e.g. AsciiChem)."
  spec.homepage      = "https://github.com/lutaml/chemml"
  spec.license       = "BSD-2-Clause"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lutaml/chemml"
  spec.metadata["changelog_uri"] = "https://github.com/lutaml/chemml/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "lutaml-model", "~> 0.8"
end
