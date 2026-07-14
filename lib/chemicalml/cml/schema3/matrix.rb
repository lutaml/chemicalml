# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <matrix> wire class. See Chemicalml::Cml::Base::Matrix
      # for the shared attribute + xml-mapping declarations.
      class Matrix < Lutaml::Model::Serializable
        include Base::Matrix
        include Visitable
        extend Context
      end
    end
  end
end
