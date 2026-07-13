# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Formula
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Formula
            attribute :id, :string
            attribute :title, :string
            attribute :concise, :string
            attribute :inline, :string
            attribute :formal_charge, :string
            attribute :count, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :atom_array, :atomArray

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
            end
          end
        end
      end
    end
  end
end
