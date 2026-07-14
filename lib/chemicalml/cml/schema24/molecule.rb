# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <molecule> wire class. See Chemicalml::Cml::Base::Molecule
      # for the shared attribute + xml-mapping declarations.
      class Molecule < Lutaml::Model::Serializable
        include Base::Molecule
        include Visitable
        extend Context
      end
    end
  end
end
