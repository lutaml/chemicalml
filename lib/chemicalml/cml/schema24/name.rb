# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <name> wire class. See Chemicalml::Cml::Base::Name
      # for the shared attribute + xml-mapping declarations.
      class Name < Lutaml::Model::Serializable
        include Base::Name
        include Visitable
        extend Context
      end
    end
  end
end
