# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <propertylist> wire class. See Chemicalml::Cml::Base::PropertyList
      # for the shared attribute + xml-mapping declarations.
      class PropertyList < Lutaml::Model::Serializable
        include Base::PropertyList
        include Visitable
        extend Context
      end
    end
  end
end
