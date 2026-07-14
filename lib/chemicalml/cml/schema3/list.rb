# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <list> wire class. See Chemicalml::Cml::Base::List
      # for the shared attribute + xml-mapping declarations.
      class List < Lutaml::Model::Serializable
        include Base::List
        include Visitable
        extend Context
      end
    end
  end
end
