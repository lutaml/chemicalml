# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <parameter> wire class. See Chemicalml::Cml::Base::Parameter
      # for the shared attribute + xml-mapping declarations.
      class Parameter < Lutaml::Model::Serializable
        include Base::Parameter
        include Visitable
        extend Context
      end
    end
  end
end
