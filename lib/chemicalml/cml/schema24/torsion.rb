# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Torsion < Lutaml::Model::Serializable
        include Base::Torsion
        include Visitable
        extend Context
      end
    end
  end
end
