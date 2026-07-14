# frozen_string_literal: true

module Chemicalml
  module Model
    # A molecule: ordered atom list + optional bond list + optional
    # names, identifiers, formulas, properties, labels + optional
    # count (multiplicity in a larger context).
    class Molecule < Node
      attr_accessor :id, :atoms, :bonds, :names, :identifiers,
                    :formulas, :properties, :labels,
                    :count, :formal_charge, :title

      def initialize(id: nil, atoms: [], bonds: [], names: [],
                     identifiers: [], formulas: [], properties: [],
                     labels: [], count: nil, formal_charge: nil,
                     title: nil)
        @id = id
        @atoms = atoms
        @bonds = bonds
        @names = names
        @identifiers = identifiers
        @formulas = formulas
        @properties = properties
        @labels = labels
        @count = count
        @formal_charge = formal_charge
        @title = title
      end

      def children
        atoms + bonds + names + identifiers +
          formulas + properties + labels
      end

      def value_attributes
        {
          id: id, atoms: atoms, bonds: bonds, names: names,
          identifiers: identifiers, formulas: formulas,
          properties: properties, labels: labels,
          count: count, formal_charge: formal_charge, title: title
        }
      end
    end
  end
end
