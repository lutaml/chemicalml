# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class MoleculeMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A <molecule> in a molecular document MUST have an id attribute unique within document scope.'
          applies_to Chemicalml::Cml::Role::Molecule
          def check_node(node, path)
            return [] unless node.id.to_s.empty?

            [violation(path: path.empty? ? 'molecule' : path.join('/'),
                       message: 'molecule must have an id attribute')]
          end
        end
      end
    end
  end
end
