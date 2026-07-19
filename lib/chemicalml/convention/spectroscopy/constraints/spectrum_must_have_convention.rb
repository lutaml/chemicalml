# frozen_string_literal: true

module Chemicalml
  module Convention
    module Spectroscopy
      module Constraints
        # A `<spectrum>` MUST declare its own convention attribute so
        # consumers know how to interpret its format and peaks. Per
        # the molecular convention: "spectrum — any number, each MUST
        # specify its own convention".
        class SpectrumMustHaveConvention < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Spectrum

          def check_node(node, _path)
            return [] unless node.convention.to_s.empty?

            [violation(path: yield_path(node),
                       message: "spectrum #{node.id.inspect} must declare its own convention attribute")]
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
