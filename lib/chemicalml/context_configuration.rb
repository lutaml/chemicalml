# frozen_string_literal: true

module Chemicalml
  # Shared behaviour for versioned schema configurations. Each schema
  # version (`Cml::Schema3`, `Cml::Schema24`) extends this module via
  # its own `Configuration` sub-module, giving it:
  #
  #   - `context_id` — the lutaml-model `GlobalContext` id
  #   - `register_model(klass, id:)` — record one wire class
  #   - `populate_context!` — rebuild the type registry on demand
  #   - `ensure_registered!` — lazily populate on first parse
  #
  # Mirrors `Mml::ContextConfiguration`. Adapted to Chemicalml's
  # schema-registry terminology.
  module ContextConfiguration
    def context_id
      self::CONTEXT_ID
    end

    def context
      Lutaml::Model::GlobalContext.context(context_id)
    end

    def ensure_registered!
      return if @models_registered

      register_models!
      @models_registered = true
    end

    # Default: subclasses override with a centralized registration
    # block (V4-style). The fallback eager-loads every autoloaded
    # constant on the parent module.
    def register_models!
      parent = version_parent_module
      parent.constants.each { |name| parent.const_get(name) }
    end

    # Walk the shared `Chemicalml::Cml::Elements::ALL` table, look up
    # each class on the parent (schema) module, and register it. Pass
    # `except:` to skip specific elements (used by Schema 2.4 which
    # lacks `<module>`).
    def register_elements!(except: [])
      parent = version_parent_module
      skip = except.to_set
      Chemicalml::Cml::Elements::ALL.each do |class_name, element_id|
        next if skip.include?(class_name)
        next unless parent.const_defined?(class_name)

        register_model(parent.const_get(class_name), id: element_id)
      end
    end

    def register_model(klass, id:)
      normalized_id = id.to_sym
      registered_models[normalized_id] = klass
      target_context = context || create_base_context
      target_context.registry.register(normalized_id, klass)
      klass
    end

    def populate_context!
      ensure_version_registered
      Lutaml::Model::GlobalContext.unregister_context(context_id) if context
      register_models_in(base_type_context)
    end

    def create_context(id:, registry: nil, fallback_to: [context_id])
      normalized_id = id.to_sym
      ensure_version_registered
      Lutaml::Model::GlobalContext.unregister_context(normalized_id) if Lutaml::Model::GlobalContext.context(normalized_id)
      Lutaml::Model::GlobalContext.create_context(
        id: normalized_id,
        registry: registry || Lutaml::Model::TypeRegistry.new,
        fallback_to: Array(fallback_to).map(&:to_sym)
      ).tap { Lutaml::Model::GlobalContext.clear_caches }
    end

    def default_context_id
      context_id
    end

    private

    def registered_models
      @registered_models ||= {}
    end

    def create_base_context
      Lutaml::Model::GlobalContext.create_context(
        id: context_id,
        registry: Lutaml::Model::TypeRegistry.new,
        fallback_to: [:default]
      )
    end

    def base_type_context
      create_base_context
    end

    def register_models_in(type_context)
      registered_models.each do |model_id, klass|
        type_context.registry.register(model_id, klass)
      end
      Lutaml::Model::GlobalContext.clear_caches
      type_context
    end

    def ensure_version_registered
      parent = version_parent_module
      return unless parent

      parent.ensure_registered!
    end

    def version_parent_module
      return nil unless name

      parent_const_name = name.split("::")[0..-2].join("::")
      return nil if parent_const_name.empty?

      Object.const_get(parent_const_name)
    rescue NameError
      nil
    end
  end
end
