# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Action < Lutaml::Model::Serializable
        include Base::Action
        include Visitable
        extend Context
      end
    end
  end
end
