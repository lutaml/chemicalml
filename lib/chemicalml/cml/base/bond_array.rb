# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondArray
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondArray
            attribute :bonds, :bond, collection: true

            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :bond_i_d_array, :string
            attribute :atom_ref1_array, :string
            attribute :atom_ref2_array, :string
            attribute :order_array, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "bondArray"
              map_element "bond", to: :bonds
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "bondIDArray", to: :bond_i_d_array
              map_attribute "atomRef1Array", to: :atom_ref1_array
              map_attribute "atomRef2Array", to: :atom_ref2_array
              map_attribute "orderArray", to: :order_array
            end
          end
        end
      end
    end
  end
end
