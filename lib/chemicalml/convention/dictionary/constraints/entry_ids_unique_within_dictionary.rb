# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # Entry ids MUST be unique within the parent dictionary per
        # the dictionary convention.
        class EntryIdsUniqueWithinDictionary < Chemicalml::Convention::Constraint::NodeConstraint
          def check_node(node, path)
            return [] unless dictionary?(node)

            entries = node.entries || []
            ids = entries.map { |e| e.id }.compact
            duplicates = ids.group_by { |x| x }.select { |_, v| v.length > 1 }.keys
            return [] if duplicates.empty?

            duplicates.map do |dup|
              violation(path: path.join("/"),
                        message: "duplicate entry id #{dup.inspect} within dictionary")
            end
          end

          private

          def dictionary?(node)
            node.is_a?(Chemicalml::Cml::Role::Dictionary)
          end
        end
      end
    end
  end
end
