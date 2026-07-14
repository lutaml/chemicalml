# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Observation < Lutaml::Model::Serializable
        include Base::Observation
        include Visitable
        extend Context
      end
    end
  end
end
