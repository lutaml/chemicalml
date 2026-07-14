# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Lattice
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Lattice
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :latticeType, :string
            attribute :units, :string

                        attribute :lattice_vectors, :latticeVector, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "latticeVector", to: :lattice_vectors
              root "lattice"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "latticeType", to: :latticeType
              map_attribute "units", to: :units
            end
          end
        end
      end
    end
  end
end
