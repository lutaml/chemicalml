# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # `atomArray` MUST contain at least one atom. The atoms can
        # be in the child form (`<atom>` elements) or the parallel-array
        # form (`atomID` attribute with whitespace-separated ids).
        class AtomArrayMustContainAtoms < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = '`atomArray` MUST contain at least one atom. The atoms can be in the child form (`<atom>` elements) or the parallel-array form (`atomID` attribute with whitespace-separated ids).'
          applies_to Chemicalml::Cml::Role::Molecule
          def check_node(node, path)
            return [] unless node.atom_array

            aa = node.atom_array
            return [] if has_child_atoms?(aa) || has_parallel_array_atoms?(aa)

            [violation(path: path.empty? ? 'molecule' : path.join('/'),
                       message: 'atomArray must contain at least one atom')]
          end

          private

          def has_child_atoms?(atom_array)
            !(atom_array.atoms || []).empty?
          end

          # Parallel-array form is identified by a non-empty atomIDArray
          # attribute — the XSD marks it as mandatory when atoms are
          # encoded as parallel arrays.
          def has_parallel_array_atoms?(atom_array)
            !atom_array.atom_id_array.to_s.strip.empty?
          end
        end
      end
    end
  end
end
