# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      # Universal CML child elements. The XSD grants metadataList,
      # label, name, and description as children to most CML elements.
      # Mixing this module into a Base::* module adds the four child
      # declarations in one place — keeping DRY discipline.
      #
      # Opt-in: only Base modules whose XSD declares these children
      # include this mixin. This respects MECE ownership — each child
      # declaration lives in exactly one place (here, for the universal
      # set; in the specific Base module for element-specific
      # children).
      module CommonChildren
        def self.included(klass)
          klass.class_eval do
            attribute :metadata_lists, :metadataList, collection: true
            attribute :labels, :label, collection: true
            attribute :names, :name, collection: true
            attribute :descriptions, :description, collection: true

            xml do
              map_element 'metadataList', to: :metadata_lists
              map_element 'label', to: :labels
              map_element 'name', to: :names
              map_element 'description', to: :descriptions
            end
          end
        end
      end
    end
  end
end
