# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <reactant> wire class. See Chemicalml::Cml::Base::Reactant
      # for the shared attribute + xml-mapping declarations.
      class Reactant < Lutaml::Model::Serializable
        include Base::Reactant
        include Visitable
        extend Context
      end
    end
  end
end
