# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <bondarray> wire class. See Chemicalml::Cml::Base::BondArray
      # for the shared attribute + xml-mapping declarations.
      class BondArray < Lutaml::Model::Serializable
        include Base::BondArray
        include Visitable
        extend Context
      end
    end
  end
end
