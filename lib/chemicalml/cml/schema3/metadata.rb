# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <metadata> wire class. See Chemicalml::Cml::Base::Metadata
      # for the shared attribute + xml-mapping declarations.
      class Metadata < Lutaml::Model::Serializable
        include Base::Metadata
        include Visitable
        extend Context
      end
    end
  end
end
