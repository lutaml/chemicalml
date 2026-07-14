# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <dictionaryentry> wire class. See Chemicalml::Cml::Base::DictionaryEntry
      # for the shared attribute + xml-mapping declarations.
      class DictionaryEntry < Lutaml::Model::Serializable
        include Base::DictionaryEntry
        include Visitable
        extend Context
      end
    end
  end
end
