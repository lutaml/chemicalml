# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <bond> wire class. See Chemicalml::Cml::Base::Bond
      # for the shared attribute + xml-mapping declarations.
      class Bond < Lutaml::Model::Serializable
        include Base::Bond
        include Visitable
        extend Context
      end
    end
  end
end
