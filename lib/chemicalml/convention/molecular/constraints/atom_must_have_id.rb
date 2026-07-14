# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class AtomMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
          def check_node(node, path)
            return [] unless node.is_a?(Chemicalml::Cml::Role::Atom)

            return [] unless node.id.to_s.empty?

            [violation(path: path.empty? ? "atom" : path.join("/"),
                       message: "atom must have an id attribute")]
          end
        end
      end
    end
  end
end
