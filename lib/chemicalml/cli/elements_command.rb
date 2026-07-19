# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml elements` — list every CML wire class registered
    # in Schema3 with its XML element name.
    class ElementsCommand < Command
      def run(_options = {})
        Chemicalml::Cml::Schema3::Configuration.ensure_registered!
        Chemicalml::Cml::Elements::ALL.sort.each do |cls, xml_id|
          puts "#{cls.to_s.ljust(25)} → <#{xml_id}>"
        end
        0
      end
    end
  end
end
