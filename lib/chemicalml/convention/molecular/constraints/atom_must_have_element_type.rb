# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class AtomMustHaveElementType < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Atom
          def check_node(node, path)

            return [] unless node.element_type.to_s.empty?

            [violation(path: path.empty? ? 'atom' : path.join('/'),
                       message: 'atom must have an elementType attribute')]
          end
        end
      end
    end
  end
end
