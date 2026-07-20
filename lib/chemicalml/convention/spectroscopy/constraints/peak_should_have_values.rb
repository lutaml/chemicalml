# frozen_string_literal: true

module Chemicalml
  module Convention
    module Spectroscopy
      module Constraints
        # A `<peak>` SHOULD declare at least one of `xValue` or
        # `yValue`. A peak with neither carries no position
        # information. Warning severity — there are edge cases
        # (e.g. group-references) where this is intentional.
        class PeakShouldHaveValues < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<peak>` SHOULD declare at least one of `xValue` or `yValue`. A peak with neither carries no position information. Warning severity — there are edge cases'
          applies_to Chemicalml::Cml::Role::Peak

          def check_node(node, _path)
            return [] unless node.xValue.to_s.empty? && node.yValue.to_s.empty?

            [violation(path: yield_path(node),
                       message: "peak #{node.id.inspect} should have at least one of xValue or yValue",
                       severity: :warning,
                       value: { xValue: node.xValue, yValue: node.yValue }.freeze)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "peak[#{id}]" : 'peak'
          end
        end
      end
    end
  end
end
