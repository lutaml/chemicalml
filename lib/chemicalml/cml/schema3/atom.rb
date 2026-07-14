# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <atom> wire class. See Chemicalml::Cml::Base::Atom
      # for the shared attribute + xml-mapping declarations.
      class Atom < Lutaml::Model::Serializable
        include Base::Atom
        include Visitable
        extend Context
      end
    end
  end
end
