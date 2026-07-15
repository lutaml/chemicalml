# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondStereo
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondStereo
            attribute :atom_refs2, :string
            attribute :atom_refs4, :string
            attribute :dict_ref, :string
            attribute :content, :string

            attribute :atom_ref_array, :string
            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :convention_value, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "bondStereo"
              map_attribute "atomRefs2", to: :atom_refs2
              map_attribute "atomRefs4", to: :atom_refs4
              map_attribute "dictRef", to: :dict_ref
              map_content to: :content
              map_attribute "atomRefArray", to: :atom_ref_array
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "conventionValue", to: :convention_value
            end
          end
        end
      end
    end
  end
end
