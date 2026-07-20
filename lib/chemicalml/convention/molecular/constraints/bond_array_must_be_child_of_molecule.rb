# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `<bondArray>` MUST be a child of
        # `<molecule>`. Any other parent is invalid.
        class BondArrayMustBeChildOfMolecule < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Molecular convention: `<bondArray>` MUST be a child of `<molecule>`. Any other parent is invalid.'
          def check_node(node, path)
            return [] if molecule?(node)

            misplaced = node.wire_children.select { |c| bond_array?(c) }
            misplaced.map do |child|
              violation(
                path: (path + [describe(node), describe(child)]).join('/'),
                message: 'bondArray must be a child of molecule, ' \
                         "but appears under #{node.element_name.inspect}"
              )
            end
          end

          private

          def molecule?(node)
            node.is_a?(Chemicalml::Cml::Role::Molecule)
          end

          def bond_array?(node)
            node.is_a?(Chemicalml::Cml::Role::BondArray)
          end
        end
      end
    end
  end
end
