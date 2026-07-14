# frozen_string_literal: true

module Chemicalml
  module Model
    # Bond stereochemistry. CML `<bondStereo>` element. Carries
    # either `atom_refs2` (for `W`/`H` wedge/hatch) or `atom_refs4`
    # (for `C`/`T` cis/trans). The `value` is the convention letter:
    # `W`, `H`, `C`, `T`, or `other` (with a `dict_ref`).
    class BondStereo < Node
      attr_accessor :atom_refs2, :atom_refs4, :dict_ref, :value

      def initialize(value:, atom_refs2: nil, atom_refs4: nil, dict_ref: nil)
        @value = value
        @atom_refs2 = atom_refs2
        @atom_refs4 = atom_refs4
        @dict_ref = dict_ref
      end

      def value_attributes
        {
          value: value,
          atom_refs2: atom_refs2,
          atom_refs4: atom_refs4,
          dict_ref: dict_ref
        }
      end
    end
  end
end
