# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class ConditionList < Lutaml::Model::Serializable
        include Base::ConditionList
        include Visitable
        extend Context
      end
    end
  end
end
