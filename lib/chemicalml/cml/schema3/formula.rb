# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <formula> wire class. See Chemicalml::Cml::Base::Formula
      # for the shared attribute + xml-mapping declarations.
      class Formula < Lutaml::Model::Serializable
        include Base::Formula
        include Visitable
        extend Context
      end
    end
  end
end
