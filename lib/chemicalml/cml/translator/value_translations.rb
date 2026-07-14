# frozen_string_literal: true

module Chemicalml
  module Cml
    class Translator
      # Canonical-form translations for the value-container and module
      # elements introduced when the compchem / molecular conventions
      # were added. Each `*_from_canonical` method takes `schema:` and
      # resolves wire classes via `WireClassRegistry` so Schema24
      # output uses Schema24 wire classes throughout.
      module ValueTranslations
        module ClassMethods
          def scalar_to_canonical(cml_scalar)
            return nil unless cml_scalar

            Model::Scalar.new(
              value: cml_scalar.content,
              data_type: cml_scalar.data_type,
              units: cml_scalar.units,
              id: cml_scalar.id,
              title: cml_scalar.title,
              dict_ref: cml_scalar.dict_ref
            )
          end

          def scalar_from_canonical(scalar, schema: :schema3)
            return nil unless scalar

            wire_class_for(schema, Chemicalml::Cml::Role::Scalar).new(
              content: scalar.value,
              data_type: scalar.data_type,
              units: scalar.units,
              id: scalar.id,
              title: scalar.title,
              dict_ref: scalar.dict_ref
            )
          end

          def array_to_canonical(cml_array)
            return nil unless cml_array

            Model::Array.new(
              values: cml_array.content.to_s.split,
              data_type: cml_array.data_type,
              units: cml_array.units,
              size: cml_array.size,
              id: cml_array.id,
              title: cml_array.title,
              dict_ref: cml_array.dict_ref
            )
          end

          def array_from_canonical(array, schema: :schema3)
            return nil unless array

            wire_class_for(schema, Chemicalml::Cml::Role::Array).new(
              content: [*array.values].join(" "),
              data_type: array.data_type,
              units: array.units,
              size: array.size,
              id: array.id,
              title: array.title,
              dict_ref: array.dict_ref
            )
          end

          def matrix_to_canonical(cml_matrix)
            return nil unless cml_matrix

            Model::Matrix.new(
              values: cml_matrix.content.to_s.split,
              rows: cml_matrix.rows,
              columns: cml_matrix.columns,
              data_type: cml_matrix.data_type,
              units: cml_matrix.units,
              id: cml_matrix.id,
              title: cml_matrix.title,
              dict_ref: cml_matrix.dict_ref
            )
          end

          def matrix_from_canonical(matrix, schema: :schema3)
            return nil unless matrix

            wire_class_for(schema, Chemicalml::Cml::Role::Matrix).new(
              content: [*matrix.values].join(" "),
              rows: matrix.rows,
              columns: matrix.columns,
              data_type: matrix.data_type,
              units: matrix.units,
              id: matrix.id,
              title: matrix.title,
              dict_ref: matrix.dict_ref
            )
          end

          def value_container_to_canonical(cml_value)
            return nil unless cml_value

            if cml_value.is_a?(Chemicalml::Cml::Role::Matrix)
              matrix_to_canonical(cml_value)
            elsif cml_value.is_a?(Chemicalml::Cml::Role::Array)
              array_to_canonical(cml_value)
            elsif cml_value.is_a?(Chemicalml::Cml::Role::Scalar)
              scalar_to_canonical(cml_value)
            end
          end

          def value_container_from_canonical(value, schema: :schema3)
            case value
            when Model::Matrix then matrix_from_canonical(value, schema: schema)
            when Model::Array  then array_from_canonical(value, schema: schema)
            when Model::Scalar then scalar_from_canonical(value, schema: schema)
            end
          end

          def property_to_canonical(cml_prop)
            return nil unless cml_prop

            Model::Property.new(
              id: cml_prop.id,
              title: cml_prop.title,
              dict_ref: cml_prop.dict_ref,
              convention: cml_prop.convention,
              value: property_value_to_canonical(cml_prop)
            )
          end

          def property_from_canonical(prop, schema: :schema3)
            return nil unless prop

            value = value_container_from_canonical(prop.value, schema: schema)
            wire_class_for(schema, Chemicalml::Cml::Role::Property).new(
              id: prop.id,
              title: prop.title,
              dict_ref: prop.dict_ref,
              convention: prop.convention,
              scalar: value.is_a?(wire_class_for(schema, Chemicalml::Cml::Role::Scalar)) ? value : nil,
              array: value.is_a?(wire_class_for(schema, Chemicalml::Cml::Role::Array)) ? value : nil,
              matrix: value.is_a?(wire_class_for(schema, Chemicalml::Cml::Role::Matrix)) ? value : nil
            )
          end

          def parameter_to_canonical(cml_param)
            return nil unless cml_param

            Model::Parameter.new(
              id: cml_param.id,
              title: cml_param.title,
              dict_ref: cml_param.dict_ref,
              convention: cml_param.convention,
              value: parameter_value_to_canonical(cml_param)
            )
          end

          def parameter_from_canonical(param, schema: :schema3)
            return nil unless param

            value = value_container_from_canonical(param.value, schema: schema)
            wire_class_for(schema, Chemicalml::Cml::Role::Parameter).new(
              id: param.id,
              title: param.title,
              dict_ref: param.dict_ref,
              convention: param.convention,
              scalar: value.is_a?(wire_class_for(schema, Chemicalml::Cml::Role::Scalar)) ? value : nil,
              array: value.is_a?(wire_class_for(schema, Chemicalml::Cml::Role::Array)) ? value : nil,
              matrix: value.is_a?(wire_class_for(schema, Chemicalml::Cml::Role::Matrix)) ? value : nil
            )
          end

          def label_to_canonical(cml_label)
            return nil unless cml_label

            Model::Label.new(
              id: cml_label.id,
              value: cml_label.value,
              dict_ref: cml_label.dict_ref,
              convention: cml_label.convention
            )
          end

          def label_from_canonical(label, schema: :schema3)
            return nil unless label

            wire_class_for(schema, Chemicalml::Cml::Role::Label).new(
              id: label.id,
              value: label.value,
              dict_ref: label.dict_ref,
              convention: label.convention
            )
          end

          def metadata_to_canonical(cml_md)
            return nil unless cml_md

            Model::Metadata.new(
              id: cml_md.id,
              name: cml_md.name,
              content: cml_md.content,
              convention: cml_md.convention,
              title: cml_md.title
            )
          end

          def metadata_from_canonical(md, schema: :schema3)
            return nil unless md

            wire_class_for(schema, Chemicalml::Cml::Role::Metadata).new(
              id: md.id,
              name: md.name,
              content: md.content,
              convention: md.convention,
              title: md.title
            )
          end

          def formula_to_canonical(cml_formula)
            return nil unless cml_formula

            Model::Formula.new(
              id: cml_formula.id,
              concise: cml_formula.concise,
              inline: cml_formula.inline,
              formal_charge: cml_formula.formal_charge,
              count: cml_formula.count,
              title: cml_formula.title,
              convention: cml_formula.convention,
              dict_ref: cml_formula.dict_ref
            )
          end

          def formula_from_canonical(formula, schema: :schema3)
            return nil unless formula

            wire_class_for(schema, Chemicalml::Cml::Role::Formula).new(
              id: formula.id,
              concise: formula.concise,
              inline: formula.inline,
              formal_charge: formula.formal_charge,
              count: formula.count,
              title: formula.title,
              convention: formula.convention,
              dict_ref: formula.dict_ref
            )
          end

          private

          def wire_class_for(schema, role)
            Chemicalml::Cml::WireClassRegistry.for(schema, role)
          end

          def property_value_to_canonical(cml_prop)
            value_container_to_canonical(cml_prop.scalar) ||
              value_container_to_canonical(cml_prop.array) ||
              value_container_to_canonical(cml_prop.matrix)
          end

          def parameter_value_to_canonical(cml_param)
            value_container_to_canonical(cml_param.scalar) ||
              value_container_to_canonical(cml_param.array) ||
              value_container_to_canonical(cml_param.matrix)
          end
        end
      end

      extend ValueTranslations::ClassMethods
    end
  end
end
