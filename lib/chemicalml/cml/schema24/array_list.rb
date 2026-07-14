# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class ArrayList < Lutaml::Model::Serializable
        include Base::ArrayList
        include Visitable
        extend Context
      end
    end
  end
end
