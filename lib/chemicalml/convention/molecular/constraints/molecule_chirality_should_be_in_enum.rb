# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<molecule>`'s `chirality` attribute SHOULD be one of the
        # XSD chiralityType enum values:
        # enantiomer/racemate/unknown/other. Warning severity.
        class MoleculeChiralityShouldBeInEnum < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "A `<molecule>`'s `chirality` attribute SHOULD be one of the XSD chiralityType enum values: enantiomer/racemate/unknown/other. Warning severity."
          include Chemicalml::Cml::Enums

          applies_to Chemicalml::Cml::Role::Molecule

          def check_node(node, _path)
            chirality = node.chirality.to_s
            return [] if chirality.empty?
            return [] if CHIRALITY_VALUES.include?(chirality)

            [violation(path: yield_path(node),
                       message: "molecule #{node.id.inspect} chirality #{chirality.inspect} should be one of " \
                                "#{CHIRALITY_VALUES.to_a.sort.inspect}",
                       severity: :warning,
                       value: chirality)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "molecule[#{id}]" : 'molecule'
          end
        end
      end
    end
  end
end
