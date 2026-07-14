# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class TransitionState < Lutaml::Model::Serializable
        include Base::TransitionState
        include Visitable
        extend Context
      end
    end
  end
end
