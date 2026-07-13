# frozen_string_literal: true

module Chemml
  module Model
    # A bond between two atoms. Endpoint references are string IDs
    # matching `Atom#id`; the kind enum follows CML conventions.
    class Bond < Node
      KINDS = %i[single double triple quadruple aromatic wedge hash
                 dative wavy].freeze

      CML_ORDER = {
        single: "S", double: "D", triple: "T", quadruple: "Q",
        aromatic: "A", wedge: "W", hash: "H", dative: "DG", wavy: "V"
      }.freeze

      attr_accessor :id, :atom_refs, :kind

      def initialize(id: nil, atom_refs:, kind: :single)
        @id = id
        @atom_refs = atom_refs
        @kind = kind
      end

      def value_attributes
        { id: id, atom_refs: atom_refs, kind: kind }
      end

      def cml_order
        CML_ORDER.fetch(kind, "S")
      end
    end
  end
end
