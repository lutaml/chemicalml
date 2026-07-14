# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <bondstereo> wire class. See Chemicalml::Cml::Base::BondStereo
      # for the shared attribute + xml-mapping declarations.
      class BondStereo < Lutaml::Model::Serializable
        include Base::BondStereo
        include Visitable
        extend Context
      end
    end
  end
end
