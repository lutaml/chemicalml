# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <module> wire class. See Chemicalml::Cml::Base::Module
      # for the shared attribute + xml-mapping declarations.
      class Module < Lutaml::Model::Serializable
        include Base::Module
        include Visitable
        extend Context
      end
    end
  end
end
