# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class System < Lutaml::Model::Serializable
        include Base::System
        include Visitable
        extend Context
      end
    end
  end
end
