# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <array> wire class. See Chemicalml::Cml::Base::Array
      # for the shared attribute + xml-mapping declarations.
      class Array < Lutaml::Model::Serializable
        include Base::Array
        include Visitable
        extend Context
      end
    end
  end
end
