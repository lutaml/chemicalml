# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <productlist> wire class. See Chemicalml::Cml::Base::ProductList
      # for the shared attribute + xml-mapping declarations.
      class ProductList < Lutaml::Model::Serializable
        include Base::ProductList
        include Visitable
        extend Context
      end
    end
  end
end
