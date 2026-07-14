# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <identifier> wire class. See Chemicalml::Cml::Base::Identifier
      # for the shared attribute + xml-mapping declarations.
      class Identifier < Lutaml::Model::Serializable
        include Base::Identifier
        include Visitable
        extend Context
      end
    end
  end
end
