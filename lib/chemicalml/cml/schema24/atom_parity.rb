# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <atomparity> wire class. See Chemicalml::Cml::Base::AtomParity
      # for the shared attribute + xml-mapping declarations.
      class AtomParity < Lutaml::Model::Serializable
        include Base::AtomParity
        include Visitable
        extend Context
      end
    end
  end
end
