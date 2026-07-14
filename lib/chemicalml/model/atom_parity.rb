# frozen_string_literal: true

module Chemicalml
  module Model
    # Atom-centre chirality. CML `<atomParity>` element with
    # `atomRefs4` (four atom IDs in order) and a `value` (typically
    # `"1"`, `"-1"`, or `"0"`).
    class AtomParity < Node
      attr_accessor :atom_refs4, :value

      def initialize(atom_refs4:, value:)
        @atom_refs4 = atom_refs4
        @value = value
      end

      def value_attributes
        { atom_refs4: atom_refs4, value: value }
      end
    end
  end
end
