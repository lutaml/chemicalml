# frozen_string_literal: true

module Chemicalml
  module Cml
    # Schema 3 wire classes. Each is a `Lutaml::Model::Serializable`
    # subclass that includes the shared declaration mixin from
    # `Chemicalml::Cml::Base::*` and `Chemicalml::Cml::Visitable`.
    #
    # The full element set is generated in-place from
    # `Chemicalml::Cml::Elements::ALL` — adding a new CML element
    # means adding one entry there, not 35+ boilerplate files here.
    # Schema-3-specific deviations live in additional
    # `Base::Schema3Only::*` modules included by the relevant class
    # via `Base::*` mixins.
    module Schema3
      extend Chemicalml::VersionedParser
      autoload :Configuration, "chemicalml/cml/schema3/configuration"

      SCHEMA = Chemicalml::Schema::Registry.lookup(:schema3)

      Chemicalml::Cml::Elements::ALL.each_key do |class_name|
        base_module = Chemicalml::Cml::Base.const_get(class_name)
        klass = Class.new(Lutaml::Model::Serializable) do
          include base_module
          include Chemicalml::Cml::Visitable
        end
        klass.define_singleton_method(:lutaml_default_register) { :chemicalml_schema3 }
        const_set(class_name, klass)
      end

      def self.schema
        SCHEMA
      end

      def self.ensure_registered!
        Configuration.ensure_registered!
      end
    end
  end
end
