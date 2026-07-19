# frozen_string_literal: true

module Chemicalml
  module Convention
    module Spectroscopy
      module Constraints
        # A `<spectrum>` MUST contain at least one of: `<xaxis>`,
        # `<yaxis>`, `<peakList>`. An empty spectrum carries no data.
        class SpectrumMustHaveContent < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Spectrum

          def check_node(node, _path)
            return [] if node.xaxis || node.yaxis || node.peak_list

            [violation(path: yield_path(node),
                       message: "spectrum #{node.id.inspect} must contain at least one of " \
                                'xaxis, yaxis, or peakList')]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "spectrum[#{id}]" : 'spectrum'
          end
        end
      end
    end
  end
end
