# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <unittypelist> wire class. See Chemicalml::Cml::Base::UnitTypeList
      # for the shared attribute + xml-mapping declarations.
      class UnitTypeList < Lutaml::Model::Serializable
        include Base::UnitTypeList
        include Visitable
        extend Context
      end
    end
  end
end
