# frozen_string_literal: true

module Chemicalml
  module Model
    # A chemical atom. Carries every attribute CML's `<atom>` carries
    # that's chemistry-relevant: element symbol, formal charge,
    # isotope, count (multiplicity), hydrogen count, lone pairs,
    # radical electrons, spin multiplicity, 2D/3D coordinates,
    # fractional coordinates. Optional `atom_parity` for atom-centre
    # chirality.
    class Atom < Node
      attr_accessor :id, :element, :formal_charge, :isotope,
                    :count, :hydrogen_count, :lone_pairs,
                    :radical_electrons, :spin_multiplicity, :title,
                    :x2, :y2, :x3, :y3, :z3,
                    :x_fract, :y_fract, :z_fract,
                    :atom_parity

      def initialize(element:, id: nil, formal_charge: nil,
                     isotope: nil, count: nil, hydrogen_count: nil,
                     lone_pairs: nil, radical_electrons: nil,
                     spin_multiplicity: nil, title: nil,
                     x2: nil, y2: nil, x3: nil, y3: nil, z3: nil,
                     x_fract: nil, y_fract: nil, z_fract: nil,
                     atom_parity: nil)
        @element = element
        @id = id
        @formal_charge = formal_charge
        @isotope = isotope
        @count = count
        @hydrogen_count = hydrogen_count
        @lone_pairs = lone_pairs
        @radical_electrons = radical_electrons
        @spin_multiplicity = spin_multiplicity
        @title = title
        @x2 = x2
        @y2 = y2
        @x3 = x3
        @y3 = y3
        @z3 = z3
        @x_fract = x_fract
        @y_fract = y_fract
        @z_fract = z_fract
        @atom_parity = atom_parity
      end

      def children
        [atom_parity].compact
      end

      def value_attributes
        {
          element: element, id: id, formal_charge: formal_charge,
          isotope: isotope, count: count, hydrogen_count: hydrogen_count,
          lone_pairs: lone_pairs, radical_electrons: radical_electrons,
          spin_multiplicity: spin_multiplicity, title: title,
          x2: x2, y2: y2, x3: x3, y3: y3, z3: z3,
          x_fract: x_fract, y_fract: y_fract, z_fract: z_fract,
          atom_parity: atom_parity
        }
      end
    end
  end
end
