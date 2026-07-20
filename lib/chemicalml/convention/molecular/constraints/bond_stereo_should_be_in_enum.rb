# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<bondStereo>`'s `value` attribute SHOULD be one of the
        # XSD stereoType enum values: C/T/W/H/undefined/other.
        # Warning severity.
        class BondStereoShouldBeInEnum < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "A `<bondStereo>`'s `value` attribute SHOULD be one of the XSD stereoType enum values: C/T/W/H/undefined/other. Warning severity."
          include Chemicalml::Cml::Enums

          applies_to Chemicalml::Cml::Role::BondStereo

          def check_node(node, _path)
            value = node.content.to_s
            return [] if value.empty?
            return [] if STEREO_VALUES.include?(value)

            [violation(path: yield_path(node),
                       message: "bondStereo #{node.id.inspect} value #{value.inspect} should be one of " \
                                "#{STEREO_VALUES.to_a.sort.inspect}",
                       severity: :warning,
                       value: value)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "bondStereo[#{id}]" : 'bondStereo'
          end
        end
      end
    end
  end
end
