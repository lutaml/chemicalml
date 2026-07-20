# frozen_string_literal: true

module Chemicalml
  module Cml
    # Lookup table from `(schema, role)` to the schema's wire class
    # implementing that role. Used by the Translator to instantiate
    # the right class for the requested schema — eliminates the
    # hardcoded `Cml::Foo` (always Schema3) references that caused
    # `from_canonical(schema: :schema24)` to produce Schema3 children
    # inside a Schema24 document.
    #
    # Adding Schema5 later requires no changes here — the registry
    # walks the schema module's constants lazily.
    module WireClassRegistry
      SCHEMA_MODULES = {
        schema3: Chemicalml::Cml::Schema3,
        schema24: Chemicalml::Cml::Schema24
      }.freeze

      def self.for(schema, role)
        schema_module = SCHEMA_MODULES[schema.to_sym]
        raise ArgumentError, "unknown schema: #{schema.inspect}" unless schema_module

        role_name = role_name_for(role)
        raise ArgumentError, "unknown role: #{role.inspect}" unless role_name
        unless schema_module.const_defined?(role_name, false)
          raise ArgumentError,
                "#{schema_module.name} does not define #{role_name} " \
                '(not all elements exist in every schema version)'
        end

        schema_module.const_get(role_name, false)
      end

      def self.role_name_for(role)
        return role.name.split('::').last if role.is_a?(::Module)

        role.to_s
      end
    end
  end
end
