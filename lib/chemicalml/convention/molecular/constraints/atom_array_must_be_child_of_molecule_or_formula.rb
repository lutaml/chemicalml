# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `<atomArray>` MUST be a child of
        # `<molecule>` or `<formula>`. Any other parent is invalid.
        # Checked from the parent's perspective during the walk —
        # when visiting a non-molecule/non-formula node, look for
        # misplaced atomArray children.
        class AtomArrayMustBeChildOfMoleculeOrFormula < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "Molecular convention: `<atomArray>` MUST be a child of `<molecule>` or `<formula>`. Any other parent is invalid. Checked from the parent's perspective during the walk —"
          def check_node(node, path)
            return [] if allowed_parent?(node)

            misplaced = node.wire_children.select { |c| atom_array?(c) }
            misplaced.map do |child|
              violation(
                path: (path + [describe(node), describe(child)]).join('/'),
                message: 'atomArray must be a child of molecule or formula, ' \
                         "but appears under #{node.element_name.inspect}"
              )
            end
          end

          private

          def allowed_parent?(node)
            node.is_a?(Chemicalml::Cml::Role::Molecule) ||
              node.is_a?(Chemicalml::Cml::Role::Formula)
          end

          def atom_array?(node)
            node.is_a?(Chemicalml::Cml::Role::AtomArray)
          end
        end
      end
    end
  end
end
