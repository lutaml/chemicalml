# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # `atomArray` MUST contain at least one `atom` child per the
        # molecular convention.
        class AtomArrayMustContainAtoms < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Molecule
          def check_node(node, path)
            return [] unless node.atom_array

            atoms = node.atom_array.atoms || []
            return [] unless atoms.empty?

            [violation(path: path.empty? ? 'molecule' : path.join('/'),
                       message: 'atomArray must contain at least one atom')]
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
