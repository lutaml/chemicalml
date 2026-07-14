# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <unit> wire class. See Chemicalml::Cml::Base::Unit
      # for the shared attribute + xml-mapping declarations.
      class Unit < Lutaml::Model::Serializable
        include Base::Unit
        include Visitable
        extend Context
      end
    end
  end
end
