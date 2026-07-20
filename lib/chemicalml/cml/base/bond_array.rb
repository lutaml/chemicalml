# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      # Container for a list of bonds. Two equivalent serialisations:
      #
      #   <bondArray><bond atomRefs2="a1 a2" order="1"/></bondArray>
      #
      #   <bondArray atomRef1="a1 a2" atomRef2="a2 a3" order="1 2"/>
      #
      # The parallel-array form uses the wire attribute names
      # `atomRef1`, `atomRef2`, `bondID`, `order` — the XSD attribute
      # *group* is named `atomRef1Array` etc., but the wire attribute
      # is `atomRef1`.
      module BondArray
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondArray

            attribute :bonds, :bond, collection: true

            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string

            attribute :bond_id_array, :string
            attribute :atom_ref1_array, :string
            attribute :atom_ref2_array, :string
            attribute :order_array, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'bondArray'
              map_element 'bond', to: :bonds
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'convention', to: :convention
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'bondID', to: :bond_id_array
              map_attribute 'atomRef1', to: :atom_ref1_array
              map_attribute 'atomRef2', to: :atom_ref2_array
              map_attribute 'order', to: :order_array
            end
            key_value do
              map 'bond', to: :bonds
              map 'title', to: :title
              map 'id', to: :id
              map 'convention', to: :convention
              map 'dictRef', to: :dict_ref
              map 'bondID', to: :bond_id_array
              map 'atomRef1', to: :atom_ref1_array
              map 'atomRef2', to: :atom_ref2_array
              map 'order', to: :order_array
            end
          end
        end
      end
    end
  end
end
