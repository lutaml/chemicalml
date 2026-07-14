# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <metadatalist> wire class. See Chemicalml::Cml::Base::MetadataList
      # for the shared attribute + xml-mapping declarations.
      class MetadataList < Lutaml::Model::Serializable
        include Base::MetadataList
        include Visitable
        extend Context
      end
    end
  end
end
