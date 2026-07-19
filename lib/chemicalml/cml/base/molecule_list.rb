# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module MoleculeList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::MoleculeList
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :molecules, :molecule, collection: true

            attribute :ref, :string
            attribute :molecule_lists, :moleculeList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "molecule", to: :molecules
              map_element "moleculeList", to: :molecule_lists
              root "moleculeList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "molecule", to: :molecules
              map "moleculeList", to: :molecule_lists
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
            end

          end
        end
      end
    end
  end
end