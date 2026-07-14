# frozen_string_literal: true

module Chemicalml
  module Model
    # A bond between two atoms. Endpoint references are string IDs
    # matching `Atom#id`; the kind enum follows CML conventions.
    # Optional `bond_stereo` carries cis/trans/wedge/hatch info.
    class Bond < Node
      KINDS = %i[single double triple quadruple aromatic wedge hash
                 dative wavy].freeze

      CML_ORDER = {
        single: "S", double: "D", triple: "T", quadruple: "Q",
        aromatic: "A", wedge: "W", hash: "H", dative: "DG", wavy: "V"
      }.freeze

      attr_accessor :id, :atom_refs, :kind, :bond_stereo

      def initialize(id: nil, atom_refs:, kind: :single, bond_stereo: nil)
        @id = id
        @atom_refs = atom_refs
        @kind = kind
        @bond_stereo = bond_stereo
      end

      def children
        [bond_stereo].compact
      end

      def value_attributes
        { id: id, atom_refs: atom_refs, kind: kind, bond_stereo: bond_stereo }
      end

      def cml_order
        CML_ORDER.fetch(kind, "S")
      end
    end
  end
end
