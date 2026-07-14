# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Join < Lutaml::Model::Serializable
        include Base::Join
        include Visitable
        extend Context
      end
    end
  end
end
