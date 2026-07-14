# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <reactantlist> wire class. See Chemicalml::Cml::Base::ReactantList
      # for the shared attribute + xml-mapping declarations.
      class ReactantList < Lutaml::Model::Serializable
        include Base::ReactantList
        include Visitable
        extend Context
      end
    end
  end
end
