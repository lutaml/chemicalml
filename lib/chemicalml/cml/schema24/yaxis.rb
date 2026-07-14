# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Yaxis < Lutaml::Model::Serializable
        include Base::Yaxis
        include Visitable
        extend Context
      end
    end
  end
end
