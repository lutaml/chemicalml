# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <unitlist> wire class. See Chemicalml::Cml::Base::UnitList
      # for the shared attribute + xml-mapping declarations.
      class UnitList < Lutaml::Model::Serializable
        include Base::UnitList
        include Visitable
        extend Context
      end
    end
  end
end
