# frozen_string_literal: true

module Chemicalml
  module Convention
    module Spectroscopy
      module Constraints
        # A `<spectrum>` MUST have a `format` attribute (e.g. "mass",
        # "ir", "nmr", "uv") so consumers know the measurement type.
        class SpectrumMustHaveFormat < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Spectrum

          def check_node(node, _path)
            return [] unless node.format.to_s.empty?

            [violation(path: yield_path(node),
                       message: "spectrum #{node.id.inspect} must have a format attribute " \
                                "(e.g. 'mass', 'ir', 'nmr', 'uv')")]
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
