# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Sample
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Sample
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :ref, :string
            attribute :state, :string
            attribute :molecule, :molecule
            attribute :substance, :substance
            attribute :substance_lists, :substanceList, collection: true
            xml do
              namespace Chemicalml::Cml::Namespace
              root "sample"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "state", to: :state
              map_element "molecule", to: :molecule
              map_element "substance", to: :substance
              map_element "substanceList", to: :substance_lists
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "molecule", to: :molecule
              map "substance", to: :substance
              map "substanceList", to: :substance_lists
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
              map "state", to: :state
            end

          end
        end
      end
    end
  end
end