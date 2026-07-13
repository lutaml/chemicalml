# frozen_string_literal: true

module Chemicalml
  module Cml
    # Macro for defining a schema version's wire classes without
    # writing 35+ boilerplate files. Each generated class:
    #
    #   - subclasses `Lutaml::Model::Serializable`
    #   - includes the corresponding `Base::*` mixin (shared attribute
    #     declarations and xml mapping)
    #   - includes `Cml::Visitable` (uniform interface for the
    #     constraint walker)
    #   - defines `self.lutaml_default_register` returning the
    #     provided context_id
    #
    # Usage:
    #
    #   Chemicalml::Cml.define_wire_classes(
    #     namespace: Chemicalml::Cml::Schema3,
    #     context_id: :chemicalml_schema3
    #   )
    #
    # Pass `except:` to skip elements (e.g. Schema 2.4 lacks <module>):
    #
    #   Chemicalml::Cml.define_wire_classes(
    #     namespace: Chemicalml::Cml::Schema24,
    #     context_id: :chemicalml_schema24,
    #     except: Chemicalml::Cml::Elements::SCHEMA3_ONLY
    #   )
    def self.define_wire_classes(namespace:, context_id:, except: [])
      skip = except.to_set
      Elements::ALL.each_key do |class_name|
        next if skip.include?(class_name)

        base_module = Base.const_get(class_name)
        klass = Class.new(Lutaml::Model::Serializable) do
          include base_module
          include Chemicalml::Cml::Visitable
        end
        klass.define_singleton_method(:lutaml_default_register) { context_id }
        namespace.const_set(class_name, klass)
      end
    end
  end
end
