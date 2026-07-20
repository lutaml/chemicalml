# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Bonds MUST reference atoms within the same parent molecule
        # per the molecular convention.
        class BondMustReferenceAtomsInSameMolecule < Chemicalml::Convention::Constraint::DocumentConstraint
          self.description = 'Bonds MUST reference atoms within the same parent molecule per the molecular convention.'
          def check(document)
            violations = []
            walk_nodes(document) do |node, path|
              next unless molecule?(node)

              known = atom_ids_within(node).to_set
              bonds_within(node).each do |bond|
                missing = atom_refs_of(bond).reject { |r| known.include?(r) }
                next if missing.empty?

                violations << violation(
                  path: path.empty? ? "molecule[#{node.id}]" : path.join('/'),
                  message: "bond #{bond.id.inspect} references atoms not in the same molecule: #{missing.inspect}"
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

            (molecule.atom_array.atoms || []).map(&:id)
          end

          def bonds_within(molecule)
            return [] unless molecule.bond_array

            molecule.bond_array.bonds || []
          end

          def atom_refs_of(bond)
            bond.atom_refs2.to_s.split
          end
        end
      end
    end
  end
end
