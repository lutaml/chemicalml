# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `count` MUST NOT appear on top-level
        # molecules (direct children of `<cml>`). It is REQUIRED on
        # molecules nested inside another `<molecule>`.
        class MoleculeCountMustNotAppearOnTopLevel < Chemicalml::Convention::Constraint::DocumentConstraint
          self.description = 'Molecular convention: `count` MUST NOT appear on top-level molecules (direct children of `<cml>`). It is REQUIRED on molecules nested inside another `<molecule>`.'
          def check(document)
            violations = []
            top_level_molecules(document).each do |mol, path|
              next if mol.count.to_s.empty?

              violations << violation(
                path: (path + [describe(mol)]).join('/'),
                message: "top-level molecule #{mol.id.inspect} must not have " \
                         'a count attribute (only nested molecules may carry count)'
              )
            end
            violations
          end

          private

          def top_level_molecules(document)
            (document.molecules || []).map { |m| [m, []] }
          end
        end
      end
    end
  end
end
