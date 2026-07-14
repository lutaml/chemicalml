# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Xaxis < Lutaml::Model::Serializable
        include Base::Xaxis
        include Visitable
        extend Context
      end
    end
  end
end
