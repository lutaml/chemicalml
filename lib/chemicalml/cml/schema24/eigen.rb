# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Eigen < Lutaml::Model::Serializable
        include Base::Eigen
        include Visitable
        extend Context
      end
    end
  end
end
