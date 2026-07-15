# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: a `<bond>` `id` MUST be unique within
        # the eldest containing molecule. Mirrors the existing
        # `AtomIdsUniqueWithinMolecule` constraint for bonds.
        class BondIdsUniqueWithinMolecule < Chemicalml::Convention::Constraint::DocumentConstraint
          def check(document)
            violations = []
            walk_nodes(document) do |node, path|
              next unless molecule?(node)

              ids = bond_ids_within(node)
              duplicates = ids.group_by { |x| x }.select { |_, v| v.length > 1 }.keys
              duplicates.each do |dup|
                violations << violation(
                  path: (path + [describe(node)]).join('/'),
                  message: "duplicate bond id #{dup.inspect} within molecule #{node.id.inspect}"
                )
              end
            end
            violations
          end

          private

          def molecule?(node)
            node.is_a?(Chemicalml::Cml::Role::Molecule)
          end

          def bond_ids_within(molecule)
            return [] unless molecule.bond_array

            (molecule.bond_array.bonds || []).map(&:id).compact
          end
        end
      end
    end
  end
end
