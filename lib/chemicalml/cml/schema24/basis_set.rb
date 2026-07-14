# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class BasisSet < Lutaml::Model::Serializable
        include Base::BasisSet
        include Visitable
        extend Context
      end
    end
  end
end
