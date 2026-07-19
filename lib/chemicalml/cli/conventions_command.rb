# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml conventions` — list every registered convention
    # by QName, sorted.
    class ConventionsCommand < Command
      def run(_options = {})
        Chemicalml::Convention::Registry.builtin_qnames.sort.each { |q| puts q }
        0
      end
    end
  end
end
