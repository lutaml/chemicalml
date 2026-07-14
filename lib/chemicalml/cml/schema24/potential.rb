# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Potential < Lutaml::Model::Serializable
        include Base::Potential
        include Visitable
        extend Context
      end
    end
  end
end
