# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<bond>`'s `order` attribute SHOULD be one of the XSD
        # orderType enum values: S/1/D/2/T/3/A/unknown/other.
        # Warning severity — CML permits extension values via
        # convention-specific dicts.
        class BondOrderShouldBeInEnum < Chemicalml::Convention::Constraint::NodeConstraint
          include Chemicalml::Cml::Enums

          applies_to Chemicalml::Cml::Role::Bond

          def check_node(node, _path)
            order = node.order.to_s
            return [] if order.empty?
            return [] if ORDER_VALUES.include?(order)

            [violation(path: yield_path(node),
                       message: "bond #{node.id.inspect} order #{order.inspect} should be one of " \
                                "#{ORDER_VALUES.to_a.sort.inspect}",
                       severity: :warning,
                       value: order)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "bond[#{id}]" : 'bond'
          end
        end
      end
    end
  end
end
