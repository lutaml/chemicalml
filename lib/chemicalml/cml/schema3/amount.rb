# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Amount < Lutaml::Model::Serializable
        include Base::Amount
        include Visitable
        extend Context
      end
    end
  end
end
