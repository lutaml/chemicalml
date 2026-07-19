# frozen_string_literal: true

module Chemicalml
  module Convention
    module Spectroscopy
      module Constraints
        # A `<peakList>` MUST contain at least one `<peak>` or
        # `<peakGroup>` child. An empty peakList carries no data.
        class PeakListMustContainPeaks < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::PeakList

          def check_node(node, _path)
            peaks = (node.peaks || []) + (node.peak_groups || [])
            return [] unless peaks.empty?

            [violation(path: yield_path(node),
                       message: 'peakList must contain at least one peak or peakGroup')]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "peakList[#{id}]" : 'peakList'
          end
        end
      end
    end
  end
end
