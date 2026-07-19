# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Formula
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Formula
            include Chemicalml::Cml::Base::CommonChildren
            attribute :id, :string
            attribute :title, :string
            attribute :concise, :string
            attribute :inline, :string
            attribute :formal_charge, :string
            attribute :count, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :atom_array, :atomArray

            attribute :formulas_inner, :formula, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "formula"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "concise", to: :concise
              map_attribute "inline", to: :inline
              map_attribute "formalCharge", to: :formal_charge
              map_attribute "count", to: :count
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_element "atomArray", to: :atom_array
              map_element "formula", to: :formulas_inner
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "atomArray", to: :atom_array
              map "formula", to: :formulas_inner
              map "id", to: :id
              map "title", to: :title
              map "concise", to: :concise
              map "inline", to: :inline
              map "formalCharge", to: :formal_charge
              map "count", to: :count
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
            end

          end
        end
      end
    end
  end
end