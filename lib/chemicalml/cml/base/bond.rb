# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Bond
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Bond
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :atom_refs2, :string
            attribute :atom_refs, :string
            attribute :order, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :bond_stereo, :bondStereo
            attribute :bond_type, :bondType
            attribute :electrons, :electron, collection: true

            attribute :convention, :string
            attribute :ref, :string
            attribute :bond_refs, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'bond'
              map_attribute 'id', to: :id
              map_attribute 'atomRefs2', to: :atom_refs2
              map_attribute 'atomRefs', to: :atom_refs
              map_attribute 'order', to: :order
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_element 'bondStereo', to: :bond_stereo
              map_element 'bondType', to: :bond_type
              map_element 'electron', to: :electrons
              map_attribute 'convention', to: :convention
              map_attribute 'ref', to: :ref
              map_attribute 'bondRefs', to: :bond_refs
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'bondStereo', to: :bond_stereo
              map 'bondType', to: :bond_type
              map 'electron', to: :electrons
              map 'id', to: :id
              map 'atomRefs2', to: :atom_refs2
              map 'atomRefs', to: :atom_refs
              map 'order', to: :order
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'ref', to: :ref
              map 'bondRefs', to: :bond_refs
            end
          end
        end
      end
    end
  end
end
