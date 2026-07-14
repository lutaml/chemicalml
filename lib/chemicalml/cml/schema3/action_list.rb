# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class ActionList < Lutaml::Model::Serializable
        include Base::ActionList
        include Visitable
        extend Context
      end
    end
  end
end
