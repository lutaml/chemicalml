# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class ReactiveCentre < Lutaml::Model::Serializable
        include Base::ReactiveCentre
        include Visitable
        extend Context
      end
    end
  end
end
