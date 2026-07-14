# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <scalar> wire class. See Chemicalml::Cml::Base::Scalar
      # for the shared attribute + xml-mapping declarations.
      class Scalar < Lutaml::Model::Serializable
        include Base::Scalar
        include Visitable
        extend Context
      end
    end
  end
end
