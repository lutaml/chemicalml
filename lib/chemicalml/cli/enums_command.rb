# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml enums` — list every `Cml::Enums` constant with
    # its allowed values.
    class EnumsCommand < Command
      def run(_options = {})
        Chemicalml::Cml::Enums.constants(false).sort.each do |name|
          values = Chemicalml::Cml::Enums.const_get(name)
          puts "#{name} (#{values.size}): #{values.to_a.sort.first(20).join(', ')}"
        end
        0
      end
    end
  end
end
