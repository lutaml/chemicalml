# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <atomarray> wire class. See Chemicalml::Cml::Base::AtomArray
      # for the shared attribute + xml-mapping declarations.
      class AtomArray < Lutaml::Model::Serializable
        include Base::AtomArray
        include Visitable
        extend Context
      end
    end
  end
end
