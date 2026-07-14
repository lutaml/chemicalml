# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class BondSet < Lutaml::Model::Serializable
        include Base::BondSet
        include Visitable
        extend Context
      end
    end
  end
end
