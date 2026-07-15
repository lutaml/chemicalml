# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BasisSet
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BasisSet
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :atomic_basis_functions, :atomicBasisFunction, collection: true

            attribute :ref, :string
            attribute :role, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "atomicBasisFunction", to: :atomic_basis_functions
              root "basisSet"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "role", to: :role
            end
          end
        end
      end
    end
  end
end
