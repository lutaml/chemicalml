# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class BondType < Lutaml::Model::Serializable
        include Base::BondType
        include Visitable
        extend Context
      end
    end
  end
end
