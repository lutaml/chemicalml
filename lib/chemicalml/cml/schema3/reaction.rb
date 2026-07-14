# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <reaction> wire class. See Chemicalml::Cml::Base::Reaction
      # for the shared attribute + xml-mapping declarations.
      class Reaction < Lutaml::Model::Serializable
        include Base::Reaction
        include Visitable
        extend Context
      end
    end
  end
end
