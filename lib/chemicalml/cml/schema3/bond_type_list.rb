# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class BondTypeList < Lutaml::Model::Serializable
        include Base::BondTypeList
        include Visitable
        extend Context
      end
    end
  end
end
