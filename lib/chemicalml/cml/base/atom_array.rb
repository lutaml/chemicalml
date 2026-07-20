# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      # Container for a list of atoms. Two equivalent serialisations:
      #
      #   <atomArray><atom id="a1" elementType="C"/></atomArray>
      #
      #   <atomArray atomID="a1 a2" elementType="C O" x3="0.0 1.0"/>
      #
      # The parallel-array form uses the *same* XML attribute names as
      # the singular `<atom>` (e.g. `elementType`, `x3`), NOT names
      # like `elementTypeArray`. The XSD names the attribute *groups*
      # `elementTypeArray` etc., but the wire attribute is `elementType`.
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

            # Parallel-array attributes. Wire names match the singular
            # <atom> attributes; the Ruby names use _array suffix for
            # clarity at the call site.
            attribute :atom_id_array, :string
            attribute :count_array, :string
            attribute :element_type_array, :string
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
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'atomArray'
              map_element 'atom', to: :atoms
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'convention', to: :convention
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'ref', to: :ref
              map_attribute 'atomID', to: :atom_id_array
              map_attribute 'count', to: :count_array
              map_attribute 'elementType', to: :element_type_array
              map_attribute 'formalCharge', to: :formal_charge_array
              map_attribute 'hydrogenCount', to: :hydrogen_count_array
              map_attribute 'occupancy', to: :occupancy_array
              map_attribute 'x2', to: :x2_array
              map_attribute 'y2', to: :y2_array
              map_attribute 'x3', to: :x3_array
              map_attribute 'y3', to: :y3_array
              map_attribute 'z3', to: :z3_array
              map_attribute 'xFract', to: :x_fract_array
              map_attribute 'yFract', to: :y_fract_array
              map_attribute 'zFract', to: :z_fract_array
            end
            key_value do
              map 'atom', to: :atoms
              map 'title', to: :title
              map 'id', to: :id
              map 'convention', to: :convention
              map 'dictRef', to: :dict_ref
              map 'ref', to: :ref
              map 'atomID', to: :atom_id_array
              map 'count', to: :count_array
              map 'elementType', to: :element_type_array
              map 'formalCharge', to: :formal_charge_array
              map 'hydrogenCount', to: :hydrogen_count_array
              map 'occupancy', to: :occupancy_array
              map 'x2', to: :x2_array
              map 'y2', to: :y2_array
              map 'x3', to: :x3_array
              map 'y3', to: :y3_array
              map 'z3', to: :z3_array
              map 'xFract', to: :x_fract_array
              map 'yFract', to: :y_fract_array
              map 'zFract', to: :z_fract_array
            end
          end
        end
      end
    end
  end
end
