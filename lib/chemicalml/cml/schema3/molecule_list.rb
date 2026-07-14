# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class MoleculeList < Lutaml::Model::Serializable
        include Base::MoleculeList
        include Visitable
        extend Context
      end
    end
  end
end
