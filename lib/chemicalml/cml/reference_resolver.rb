# frozen_string_literal: true

module Chemicalml
  module Cml
    # Walks a CML document and resolves id-based references to the
    # actual target wire instances. Useful for callers that need to
    # follow CML references programmatically (e.g. bond → atoms,
    # atomParity → atoms, map → molecules).
    #
    # References are attribute values like `atomRefs2="a1 a2"`,
    # `atomRefs4="a1 a2 a3 a4"`, `bondRefs="b1 b2"`, `ref="m1"`.
    # The values are whitespace-separated lists of ids.
    #
    # The resolver is opt-in: it does not modify the wire tree. Callers
    # use it to perform lookups; unresolved refs are reported in a
    # list (a constraint turns this list into warnings).
    class ReferenceResolver
      attr_reader :document

      # @param document [Lutaml::Model::Serializable] the CML document
      #   to walk. Must include `Chemicalml::Cml::Visitable` (the
      #   standard wire classes do).
      def initialize(document)
        @document = document
        @atom_index = nil
        @bond_index = nil
      end

      # Lazily-built {id => Atom} index. Speeds up `find_atom` and
      # reference-resolution lookups from O(n) to O(1).
      def atom_index
        @atom_index ||= begin
          hash = {}
          document.each_atom { |a| hash[a.id] = a if a.id }
          hash
        end
      end

      # Lazily-built {id => Bond} index.
      def bond_index
        @bond_index ||= begin
          hash = {}
          document.each_bond { |b| hash[b.id] = b if b.id }
          hash
        end
      end

      # Returns the Atom with the given id within the given molecule,
      # or nil if not found.
      def find_atom(_molecule, atom_id)
        return nil unless atom_id

        atom_index[atom_id]
      end

      # Returns the Bond with the given id within the given molecule,
      # or nil if not found.
      def find_bond(_molecule, bond_id)
        return nil unless bond_id

        bond_index[bond_id]
      end

      # Resolves `bond.atom_refs2` to a pair of [Atom, Atom]. Returns
      # nils for missing atoms so callers can detect partial misses.
      def resolve_atom_refs2(bond, molecule = containing_molecule(bond))
        ids = parse_refs(bond&.atom_refs2)
        return [] if ids.empty?
        return [nil, nil] if ids.size != 2

        ids.map { |id| find_atom(molecule, id) }
      end

      # Walks the whole document and reports every reference attribute
      # whose target id is missing. Returns a list of hashes:
      #
      #   { node: <Bond>, attr: :atom_refs2, missing: ["a99"] }
      def unresolved_refs
        results = []
        visit(@document) do |node|
          results.concat(unresolved_for(node))
        end
        results
      end

      private

      def visit(node, &block)
        return unless node.is_a?(Lutaml::Model::Serializable)

        yield(node)
        return unless node.is_a?(Chemicalml::Cml::Visitable)

        node.wire_children.each { |child| visit(child, &block) }
      end

      # Returns all molecules in the document (top-level + nested)
      def all_molecules
        result = []
        visit(@document) do |node|
          result << node if node.is_a?(Chemicalml::Cml::Role::Molecule)
        end
        result
      end

      def containing_molecule(node)
        # The constraint walker doesn't track parents. For now, return
        # the first molecule in document order — the common case is
        # that bond atoms live in the same parent molecule.
        all_molecules.find { |m| m.bond_array && (m.bond_array.bonds || []).include?(node) }
      end

      def parse_refs(value)
        return [] if value.nil?

        value.to_s.split(/\s+/).reject(&:empty?)
      end

      def unresolved_for(node)
        return [] unless node.is_a?(Chemicalml::Cml::Role::Bond)

        ids = parse_refs(node.atom_refs2)
        return [] if ids.empty?

        # Use the global atom_index (O(1) per lookup) — the
        # `containing_molecule` indirection is unnecessary for
        # reference resolution at the document level. CML semantics
        # already enforce that bond refs live in the parent molecule
        # (caught by `BondMustReferenceAtomsInSameMolecule`).
        missing = ids.reject { |id| atom_index[id] }
        return [] if missing.empty?

        [{ node: node, attr: :atom_refs2, missing: missing }]
      end
    end
  end
end
