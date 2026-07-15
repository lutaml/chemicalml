# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Bond
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Bond
            attribute :id, :string
            attribute :atom_refs2, :string
            attribute :order, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :bond_stereo, :bondStereo

            attribute :convention, :string
            attribute :ref, :string
            attribute :bond_refs, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "bond"
              map_attribute "id", to: :id
              map_attribute "atomRefs2", to: :atom_refs2
              map_attribute "order", to: :order
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_element "bondStereo", to: :bond_stereo
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "bondRefs", to: :bond_refs
            end
          end
        end
      end
    end
  end
end
