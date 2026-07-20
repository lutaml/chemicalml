# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Walks the document via `Cml::ReferenceResolver` and reports
        # every bond whose `atomRefs2` references atoms that don't
        # exist in the parent molecule. Warning severity — there are
        # edge cases (inter-molecular bonds in transition states).
        #
        # DocumentConstraint because it needs the whole tree to
        # resolve references.
        class ReferencesShouldResolve < Chemicalml::Convention::Constraint::DocumentConstraint
          self.description = "Walks the document via `Cml::ReferenceResolver` and reports every bond whose `atomRefs2` references atoms that don't exist in the parent molecule. Warning severity — there are"
          def check(document)
            resolver = Chemicalml::Cml::ReferenceResolver.new(document)
            resolver.unresolved_refs.map do |entry|
              violation(path: describe(entry[:node]),
                        message: "bond #{entry[:node].id.inspect} #{entry[:attr]} references " \
                                 "missing atoms: #{entry[:missing].inspect}",
                        severity: :warning,
                        value: entry[:missing])
            end
          end

          private

          def describe(node)
            id = node.node_id
            id ? "#{node.element_name}[#{id}]" : node.element_name
          end
        end
      end
    end
  end
end
