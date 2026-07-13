# frozen_string_literal: true

module Chemml
  module Model
    # A chemical atom. Carries every attribute CML's `<atom>` carries
    # that's chemistry-relevant: element symbol, formal charge,
    # isotope, count (multiplicity), hydrogen count, lone pairs,
    # radical electrons, spin multiplicity.
    class Atom < Node
      attr_accessor :id, :element, :formal_charge, :isotope,
                    :count, :hydrogen_count, :lone_pairs,
                    :radical_electrons, :spin_multiplicity, :title

      def initialize(element:, id: nil, formal_charge: nil,
                     isotope: nil, count: nil, hydrogen_count: nil,
                     lone_pairs: nil, radical_electrons: nil,
                     spin_multiplicity: nil, title: nil)
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
      end

      def value_attributes
        {
          element: element, id: id, formal_charge: formal_charge,
          isotope: isotope, count: count, hydrogen_count: hydrogen_count,
          lone_pairs: lone_pairs, radical_electrons: radical_electrons,
          spin_multiplicity: spin_multiplicity, title: title
        }
      end
    end
  end
end
