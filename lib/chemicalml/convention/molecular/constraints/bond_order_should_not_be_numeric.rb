# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class BondOrderShouldNotBeNumeric < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "A <bond>'s order attribute SHOULD be one of S/D/T/Q/A or 'other' (numeric values are not recommended)."
          applies_to Chemicalml::Cml::Role::Bond
          VALID_ORDERS = %w[S D T Q A other].freeze

          def check_node(node, path)
            order = node.order.to_s
            return [] if order.empty?

            return [] if VALID_ORDERS.include?(order) || node.dict_ref.to_s.size.positive?

            [violation(path: path.empty? ? 'bond' : path.join('/'),
                       message: "bond order #{order.inspect} is not recommended " \
                                "(use S/D/T/Q/A or 'other' with dictRef)",
                       severity: :warning)]
          end
        end
      end
    end
  end
end
