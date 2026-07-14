# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <property> wire class. See Chemicalml::Cml::Base::Property
      # for the shared attribute + xml-mapping declarations.
      class Property < Lutaml::Model::Serializable
        include Base::Property
        include Visitable
        extend Context
      end
    end
  end
end
