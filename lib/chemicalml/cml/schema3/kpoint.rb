# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Kpoint < Lutaml::Model::Serializable
        include Base::Kpoint
        include Visitable
        extend Context
      end
    end
  end
end
