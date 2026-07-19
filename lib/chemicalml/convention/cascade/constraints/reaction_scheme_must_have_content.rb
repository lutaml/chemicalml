# frozen_string_literal: true

module Chemicalml
  module Convention
    module Cascade
      module Constraints
        # A `<reactionScheme>` MUST contain at least one
        # `<reactionStepList>` or `<reaction>` child. An empty scheme
        # carries no cascade information.
        class ReactionSchemeMustHaveContent < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::ReactionScheme

          def check_node(node, _path)
            return [] unless (node.reaction_step_lists || []).empty? &&
                             (node.reactions || []).empty?

            [violation(path: yield_path(node),
                       message: "reactionScheme #{node.id.inspect} must contain at least one " \
                                'reactionStepList or reaction')]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "reactionScheme[#{id}]" : 'reactionScheme'
          end
        end
      end
    end
  end
end
