# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class LatticeVector < Lutaml::Model::Serializable
        include Base::LatticeVector
        include Visitable
        extend Context
      end
    end
  end
end
