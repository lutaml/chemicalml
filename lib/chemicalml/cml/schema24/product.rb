# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <product> wire class. See Chemicalml::Cml::Base::Product
      # for the shared attribute + xml-mapping declarations.
      class Product < Lutaml::Model::Serializable
        include Base::Product
        include Visitable
        extend Context
      end
    end
  end
end
