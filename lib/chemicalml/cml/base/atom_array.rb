# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomArray
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomArray
            attribute :atoms, :atom, collection: true

            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :ref, :string
            attribute :element_type_array, :string
            attribute :count_array, :string
            attribute :formal_charge_array, :string
            attribute :hydrogen_count_array, :string
            attribute :occupancy_array, :string
            attribute :x2_array, :string
            attribute :y2_array, :string
            attribute :x3_array, :string
            attribute :y3_array, :string
            attribute :z3_array, :string
            attribute :x_fract_array, :string
            attribute :y_fract_array, :string
            attribute :z_fract_array, :string
            attribute :atom_i_d_array, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "atomArray"
              map_element "atom", to: :atoms
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "ref", to: :ref
              map_attribute "elementTypeArray", to: :element_type_array
              map_attribute "countArray", to: :count_array
              map_attribute "formalChargeArray", to: :formal_charge_array
              map_attribute "hydrogenCountArray", to: :hydrogen_count_array
              map_attribute "occupancyArray", to: :occupancy_array
              map_attribute "x2Array", to: :x2_array
              map_attribute "y2Array", to: :y2_array
              map_attribute "x3Array", to: :x3_array
              map_attribute "y3Array", to: :y3_array
              map_attribute "z3Array", to: :z3_array
              map_attribute "xFractArray", to: :x_fract_array
              map_attribute "yFractArray", to: :y_fract_array
              map_attribute "zFractArray", to: :z_fract_array
              map_attribute "atomIDArray", to: :atom_i_d_array
            end
          end
        end
      end
    end
  end
end
