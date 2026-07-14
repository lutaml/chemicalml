# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Fragment < Lutaml::Model::Serializable
        include Base::Fragment
        include Visitable
        extend Context
      end
    end
  end
end
