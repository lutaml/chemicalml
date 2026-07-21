# frozen_string_literal: true

module Chemicalml
  # Dictionary model layer. Canonical, format-agnostic representation
  # of CML dictionaries (the dictionary, unit-dictionary, and
  # unitType-dictionary conventions all share this shape).
  #
  # Built-in dictionaries ship as YAML under `data/dictionaries/` and
  # are loaded into `Chemicalml::Dictionary::Registry` lazily.
  module Dictionary
    autoload :Entry,   'chemicalml/dictionary/entry'
    autoload :Enum,    'chemicalml/dictionary/enum'
    autoload :Link,    'chemicalml/dictionary/link'
    autoload :Loader,  'chemicalml/dictionary/loader'
    autoload :Model,   'chemicalml/dictionary/model'
    autoload :Registry, 'chemicalml/dictionary/registry'

    BUILTIN_DIR = File.expand_path('../../data/dictionaries', __dir__).freeze

    # Convenience: load a built-in dictionary by short name.
    #
    # @param name [Symbol, String] the dictionary short name (YAML
    #   filename stem, e.g. `:compchem`, `:cml`).
    # @return [Chemicalml::Dictionary::Model] the loaded dictionary.
    # @raise [KeyError] if `name` is not a built-in dictionary.
    def self.load(name)
      Registry.load_builtin(name)
    end
  end
end
