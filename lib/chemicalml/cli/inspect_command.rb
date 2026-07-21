# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml inspect <file>` — print a tree-style summary of
    # the document: element names, ids, nested children.
    class InspectCommand < Command
      def run(options)
        path = options[:file]
        unless path
          stderr 'inspect requires a <file> argument'
          return 2
        end

        doc = Chemicalml.parse(File.read(path), schema: :schema3)
        print_tree(doc, 0)
        0
      rescue ArgumentError, Lutaml::Model::InvalidFormatError => e
        stderr "FAIL: #{e.message}"
        2
      end

      private

      def print_tree(node, depth, max_depth: 6)
        return if depth > max_depth
        return unless node.is_a?(Lutaml::Model::Serializable)

        indent = '  ' * depth
        line = "#{indent}#{node.class.name.split('::').last}"
        line += " [#{node.node_id}]" if node.is_a?(Chemicalml::Cml::Visitable) && node.node_id
        puts line
        return unless node.is_a?(Chemicalml::Cml::Visitable)

        node.wire_children.each { |c| print_tree(c, depth + 1, max_depth: max_depth) }
      end
    end
  end
end
