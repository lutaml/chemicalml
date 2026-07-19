# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Lattice
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Lattice
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :latticeType, :string
            attribute :units, :string

                        attribute :lattice_vectors, :latticeVector, collection: true
            attribute :matrices, :matrix, collection: true
            attribute :scalars, :scalar, collection: true
            attribute :symmetries, :symmetry, collection: true

            attribute :space_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "latticeVector", to: :lattice_vectors
              map_element "matrix", to: :matrices
              map_element "scalar", to: :scalars
              map_element "symmetry", to: :symmetries
              root "lattice"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "latticeType", to: :latticeType
              map_attribute "units", to: :units
              map_attribute "spaceType", to: :space_type
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "latticeVector", to: :lattice_vectors
              map "matrix", to: :matrices
              map "scalar", to: :scalars
              map "symmetry", to: :symmetries
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "latticeType", to: :latticeType
              map "units", to: :units
              map "spaceType", to: :space_type
            end

          end
        end
      end
    end
  end
end