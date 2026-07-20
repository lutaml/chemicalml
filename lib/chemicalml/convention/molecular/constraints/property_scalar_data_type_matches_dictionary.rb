# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<property>` with a `dictRef` whose dictionary entry declares
        # a `dataType` SHOULD have a child `<scalar>` whose `dataType`
        # attribute matches. Catches inconsistencies like a property
        # declaring `dictRef="cml:bp"` (boiling point, xsd:float) but
        # carrying a `<scalar dataType="xsd:string">`.
        #
        # Warning severity — some dictionaries allow multiple dataTypes.
        class PropertyScalarDataTypeMatchesDictionary < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<property>` with a `dictRef` whose dictionary entry declares a `dataType` SHOULD have a child `<scalar>` whose `dataType` attribute matches. Catches inconsistencies like a property'
          applies_to Chemicalml::Cml::Role::Property

          def check_node(node, _path)
            dict_ref = node.dict_ref.to_s
            return [] if dict_ref.empty?

            entry = lookup_entry(dict_ref)
            return [] unless entry

            expected_type = entry.data_type.to_s
            return [] if expected_type.empty?

            scalar = node.scalar
            return [] unless scalar

            actual_type = scalar.data_type.to_s
            return [] if actual_type.empty?
            return [] if actual_type == expected_type

            [violation(path: yield_path(node),
                       message: "property #{node.id.inspect} dictRef #{dict_ref.inspect} " \
                                "expects dataType #{expected_type.inspect} but scalar has #{actual_type.inspect}",
                       severity: :warning,
                       value: { expected: expected_type, actual: actual_type }.freeze)]
          end

          private

          def lookup_entry(dict_ref)
            Chemicalml::Dictionary::Registry.lookup(dict_ref)
          rescue StandardError
            nil
          end

          def yield_path(node)
            id = node.node_id
            id ? "property[#{id}]" : 'property'
          end
        end
      end
    end
  end
end
