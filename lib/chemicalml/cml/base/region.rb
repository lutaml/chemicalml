# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Region
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Region
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :sphere3, :string
            attribute :box3, :string
            attribute :atom_set_ref, :string
            attribute :region_refs, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "region"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "sphere3", to: :sphere3
              map_attribute "box3", to: :box3
              map_attribute "atomSetRef", to: :atom_set_ref
              map_attribute "regionRefs", to: :region_refs
            end
            key_value do
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "sphere3", to: :sphere3
              map "box3", to: :box3
              map "atomSetRef", to: :atom_set_ref
              map "regionRefs", to: :region_refs
            end

          end
        end
      end
    end
  end
end