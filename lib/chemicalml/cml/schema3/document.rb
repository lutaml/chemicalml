# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # CML <document> wire class. See Chemicalml::Cml::Base::Document
      # for the shared attribute + xml-mapping declarations.
      class Document < Lutaml::Model::Serializable
        include Base::Document
        include Visitable
        extend Context
      end
    end
  end
end
