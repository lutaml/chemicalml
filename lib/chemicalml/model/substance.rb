# frozen_string_literal: true

module ChemicalML
  module Model
    # A reaction participant. Wraps a `Molecule` with a `role`
    # (e.g. `:reactant`, `:product`, `:catalyst`, `:solvent`).
    class Substance < Node
      attr_accessor :molecule, :role, :title

      def initialize(molecule:, role: nil, title: nil)
        @molecule = molecule
        @role = role
        @title = title
      end

      def children
        [molecule]
      end

      def value_attributes
        { molecule: molecule, role: role, title: title }
      end
    end
  end
end
