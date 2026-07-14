# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class AtomType < Lutaml::Model::Serializable
        include Base::AtomType
        include Visitable
        extend Context
      end
    end
  end
end
