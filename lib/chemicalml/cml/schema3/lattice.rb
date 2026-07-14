# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Lattice < Lutaml::Model::Serializable
        include Base::Lattice
        include Visitable
        extend Context
      end
    end
  end
end
