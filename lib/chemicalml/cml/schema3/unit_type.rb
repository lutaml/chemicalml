# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <unittype> wire class. See Chemicalml::Cml::Base::UnitType
      # for the shared attribute + xml-mapping declarations.
      class UnitType < Lutaml::Model::Serializable
        include Base::UnitType
        include Visitable
        extend Context
      end
    end
  end
end
