# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class ReactionStepList < Lutaml::Model::Serializable
        include Base::ReactionStepList
        include Visitable
        extend Context
      end
    end
  end
end
