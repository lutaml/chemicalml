# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml dictionaries` — list built-in YAML dictionaries
    # by short name.
    class DictionariesCommand < Command
      def run(_options = {})
        Chemicalml::Dictionary::Registry.builtin_names.each { |n| puts n }
        0
      end
    end
  end
end
