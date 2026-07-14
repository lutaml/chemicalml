# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <parameterlist> wire class. See Chemicalml::Cml::Base::ParameterList
      # for the shared attribute + xml-mapping declarations.
      class ParameterList < Lutaml::Model::Serializable
        include Base::ParameterList
        include Visitable
        extend Context
      end
    end
  end
end
