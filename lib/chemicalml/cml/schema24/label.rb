# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <label> wire class. See Chemicalml::Cml::Base::Label
      # for the shared attribute + xml-mapping declarations.
      class Label < Lutaml::Model::Serializable
        include Base::Label
        include Visitable
        extend Context
      end
    end
  end
end
