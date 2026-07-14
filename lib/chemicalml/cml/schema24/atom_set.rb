# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class AtomSet < Lutaml::Model::Serializable
        include Base::AtomSet
        include Visitable
        extend Context
      end
    end
  end
end
