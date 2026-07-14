# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class ReactiveCentre < Lutaml::Model::Serializable
        include Base::ReactiveCentre
        include Visitable
        extend Context
      end
    end
  end
end
