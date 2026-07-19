# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class BondMustHaveOrder < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Bond
          self.description = 'A <bond> MUST have an order attribute (S/D/T/A recommended).'

          def check_node(node, path)

            return [] unless node.order.to_s.strip.empty?

            [violation(path: path.empty? ? 'bond' : path.join('/'),
                       message: 'bond must have an order attribute')]
          end
        end
      end
    end
  end
end
