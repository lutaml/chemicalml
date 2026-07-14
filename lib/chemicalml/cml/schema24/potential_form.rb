# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class PotentialForm < Lutaml::Model::Serializable
        include Base::PotentialForm
        include Visitable
        extend Context
      end
    end
  end
end
