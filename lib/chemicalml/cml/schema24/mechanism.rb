# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Mechanism < Lutaml::Model::Serializable
        include Base::Mechanism
        include Visitable
        extend Context
      end
    end
  end
end
