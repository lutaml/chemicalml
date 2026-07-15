# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class MoleculeMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
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
