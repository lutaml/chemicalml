# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # Schema 2.4 only. Not in Schema 3.
      class StringArray < Lutaml::Model::Serializable
        include Base::StringArray
        include Visitable
        extend Context
      end
    end
  end
end
