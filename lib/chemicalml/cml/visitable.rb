# frozen_string_literal: true

module Chemicalml
  module Cml
    # Marker mixin included by every wire class. Provides a uniform
    # interface the convention-constraint walker relies on:
    #
    #   - `wire_children` returns the child wire nodes
    #   - `node_id` returns the id attribute or `nil`
    #   - `element_name` returns the XML tag name
    #
    # All three use lutaml-model's attribute registry — no duck typing.
    # A wire class that doesn't declare an `:id` attribute simply has
    # `node_id` return `nil`.
    module Visitable
      def wire_children
        declared_attribute_names.flat_map do |name|
          collect_wire_nodes(public_send(name))
        end
      end

      def node_id
        return id if declared_attribute?(:id)

        nil
      end

      def element_name
        xml_mapping = self.class.mappings[:xml]
        root = xml_mapping&.root
        root&.name || self.class.name.split('::').last
      rescue StandardError
        self.class.name.split('::').last
      end

      def collect_wire_nodes(value)
        return [] if value.nil?

        if value.is_a?(::Array)
          value.select { |v| wire_node?(v) }
        elsif wire_node?(value)
          [value]
        else
          []
        end
      end

      def wire_node?(value)
        value.is_a?(Lutaml::Model::Serializable)
      end

      def declared_attribute_names
        self.class.model.attributes.keys
      rescue StandardError
        []
      end

      def declared_attribute?(name)
        self.class.model.attributes.key?(name)
      rescue StandardError
        false
      end

      # Walk the entire subtree from this node, yielding each wire
      # instance. DFS pre-order. Useful for find-style queries and
      # aggregate counts.
      #
      # @yield [Lutaml::Model::Serializable] each wire node.
      # @return [Enumerator] without a block.
      def each_wire_node(&)
        return to_enum(:each_wire_node) unless block_given?

        walk(self, &)
      end

      # Iterate every Atom in the subtree.
      def each_atom(&)
        return to_enum(:each_atom) unless block_given?

        each_wire_node { |n| yield(n) if n.is_a?(Chemicalml::Cml::Role::Atom) }
      end

      # Iterate every Bond in the subtree.
      def each_bond(&)
        return to_enum(:each_bond) unless block_given?

        each_wire_node { |n| yield(n) if n.is_a?(Chemicalml::Cml::Role::Bond) }
      end

      # Iterate every Molecule in the subtree (top-level + nested).
      def each_molecule(&)
        return to_enum(:each_molecule) unless block_given?

        each_wire_node { |n| yield(n) if n.is_a?(Chemicalml::Cml::Role::Molecule) }
      end

      # Find the first atom in the subtree with the given id, or nil.
      def find_atom(id)
        each_atom.find { |a| a.node_id == id }
      end

      # Find the first bond in the subtree with the given id, or nil.
      def find_bond(id)
        each_bond.find { |b| b.node_id == id }
      end

      # Find the first molecule in the subtree with the given id.
      def find_molecule(id)
        each_molecule.find { |m| m.node_id == id }
      end

      # Count of every Atom in the subtree.
      def atom_count
        each_atom.count
      end

      # Count of every Bond in the subtree.
      def bond_count
        each_bond.count
      end

      # Count of every Molecule in the subtree (recursive).
      def molecule_count
        each_molecule.count
      end

      private

      def walk(node, &block)
        return unless node.is_a?(Lutaml::Model::Serializable)

        block.call(node)
        return unless node.is_a?(Chemicalml::Cml::Visitable)

        node.wire_children.each { |c| walk(c, &block) }
      end
    end
  end
end
