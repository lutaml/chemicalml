# frozen_string_literal: true

module Chemicalml
  module Convention
    module Cascade
      module Constraints
        # A `<reactionStepList>` MUST contain at least one
        # `<reactionStep>` child. An empty step list breaks the
        # cascade chain.
        class ReactionStepListMustContainSteps < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::ReactionStepList

          def check_node(node, _path)
            return [] unless (node.reaction_steps || []).empty?

            [violation(path: yield_path(node),
                       message: 'reactionStepList must contain at least one reactionStep')]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "reactionStepList[#{id}]" : 'reactionStepList'
          end
        end
      end
    end
  end
end
