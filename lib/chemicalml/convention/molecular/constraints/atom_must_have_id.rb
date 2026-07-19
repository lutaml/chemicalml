# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class AtomMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Atom
          self.description = 'An <atom> inside an atomArray in a molecule MUST have an id attribute.'

          def check_node(node, path)

            return [] unless node.id.to_s.empty?

            [violation(path: path.empty? ? 'atom' : path.join('/'),
                       message: 'atom must have an id attribute')]
          end
        end
      end
    end
  end
end
