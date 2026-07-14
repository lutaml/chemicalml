# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <dictionary> wire class. See Chemicalml::Cml::Base::Dictionary
      # for the shared attribute + xml-mapping declarations.
      class Dictionary < Lutaml::Model::Serializable
        include Base::Dictionary
        include Visitable
        extend Context
      end
    end
  end
end
