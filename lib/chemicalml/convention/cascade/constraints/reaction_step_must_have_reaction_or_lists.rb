# frozen_string_literal: true

module Chemicalml
  module Convention
    module Cascade
      module Constraints
        # A `<reactionStep>` MUST contain either a `<reaction>` child
        # or explicit `<reactantList>` + `<productList>` children. An
        # empty step is a dead-end in the cascade.
        class ReactionStepMustHaveReactionOrLists < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::ReactionStep

          def check_node(node, _path)
            return [] if node.reaction
            return [] if node.reactant_list && node.product_list

            [violation(path: yield_path(node),
                       message: "reactionStep #{node.id.inspect} must contain a reaction " \
                                'or both reactantList and productList')]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "reactionStep[#{id}]" : 'reactionStep'
          end
        end
      end
    end
  end
end
