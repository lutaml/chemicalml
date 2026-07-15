# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: a `<molecule>` MAY hold an `atomArray`
        # OR child `<molecule>` elements, but not both. The two are
        # mutually exclusive ways of describing composition.
        class MoleculeAtomArrayMutuallyExclusiveWithChildren < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Molecule
          def check_node(node, path)
            return [] if node.atom_array.nil?
            return [] if (node.molecules || []).empty?

            [violation(
              path: (path + [describe(node)]).join('/'),
              message: "molecule #{node.id.inspect} has both an atomArray " \
                       'and child molecule elements — these are mutually exclusive'
            )]
          end

          private

          def molecule?(node)
            node.is_a?(Chemicalml::Cml::Role::Molecule)
          end
        end
      end
    end
  end
end
