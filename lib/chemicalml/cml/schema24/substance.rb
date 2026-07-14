# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <substance> wire class. See Chemicalml::Cml::Base::Substance
      # for the shared attribute + xml-mapping declarations.
      class Substance < Lutaml::Model::Serializable
        include Base::Substance
        include Visitable
        extend Context
      end
    end
  end
end
