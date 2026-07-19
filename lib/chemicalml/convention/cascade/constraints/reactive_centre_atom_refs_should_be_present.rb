# frozen_string_literal: true

module Chemicalml
  module Convention
    module Cascade
      module Constraints
        # A `<reactiveCentre>` SHOULD declare its `atomRefs` attribute.
        # Without atom references the reactive centre is
        # indistinguishable from a placeholder. Warning severity —
        # consumers may use `ref` or external context instead.
        class ReactiveCentreAtomRefsShouldBePresent < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::ReactiveCentre

          def check_node(node, _path)
            return [] unless node.atomRefs.to_s.empty?

            [violation(path: yield_path(node),
                       message: "reactiveCentre #{node.id.inspect} should declare atomRefs " \
                                'to identify the reacting atoms',
                       severity: :warning)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "reactiveCentre[#{id}]" : 'reactiveCentre'
          end
        end
      end
    end
  end
end
