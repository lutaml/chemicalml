# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Atom ids MUST be unique within the eldest containing molecule
        # per the molecular convention.
        class AtomIdsUniqueWithinMolecule < Chemicalml::Convention::Constraint::DocumentConstraint
          def check(document)
            violations = []
            walk_nodes(document) do |node, path|
              next unless molecule?(node)

              ids = atom_ids_within(node)
              duplicates = ids.group_by { |x| x }.select { |_, v| v.length > 1 }.keys
              duplicates.each do |dup|
                violations << violation(
                  path: path.empty? ? "molecule[#{node.id}]" : path.join("/"),
                  message: "duplicate atom id #{dup.inspect} within molecule #{node.id.inspect}"
                )
              end
            end
            violations
          end

          private

          def molecule?(node)
            node.is_a?(Chemicalml::Cml::Role::Molecule)
          end

          def atom_ids_within(molecule)
            return [] unless molecule.atom_array

            (molecule.atom_array.atoms || []).map { |a| a.id }.compact
          end
        end
      end
    end
  end
end
