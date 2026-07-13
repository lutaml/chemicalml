# frozen_string_literal: true

module Chemicalml
  module Cml
    # Schema 2.4 wire classes. Same generation pattern as Schema 3,
    # but skips elements that don't exist in Schema 2.4 (notably
    # `<module>`, which was introduced in Schema 3).
    #
    # Schema-2.4-specific deviations live in additional
    # `Base::Schema24Only::*` modules included by the relevant class
    # via `Base::*` mixins.
    module Schema24
      extend Chemicalml::VersionedParser
      autoload :Configuration, "chemicalml/cml/schema24/configuration"

      SCHEMA = Chemicalml::Schema::Registry.lookup(:schema24)

      skip = Chemicalml::Cml::Elements::SCHEMA3_ONLY.to_set
      Chemicalml::Cml::Elements::ALL.each_key do |class_name|
        next if skip.include?(class_name)

        base_module = Chemicalml::Cml::Base.const_get(class_name)
        klass = Class.new(Lutaml::Model::Serializable) do
          include base_module
          include Chemicalml::Cml::Visitable
        end
        klass.define_singleton_method(:lutaml_default_register) { :chemicalml_schema24 }
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
