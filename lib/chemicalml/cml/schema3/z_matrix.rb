# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class ZMatrix < Lutaml::Model::Serializable
        include Base::ZMatrix
        include Visitable
        extend Context
      end
    end
  end
end
