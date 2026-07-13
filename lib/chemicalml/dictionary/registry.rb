# frozen_string_literal: true

module Chemicalml
  module Dictionary
    # Registry of built-in dictionaries. Lazily loads YAML from
    # `data/dictionaries/` on first access; subsequent lookups hit the
    # in-memory cache.
    #
    # Adding a new built-in dictionary = dropping a new `.yaml` file
    # under `data/dictionaries/`. No code change required.
    module Registry
      @cache = {}
      @mutex = Mutex.new

      def self.lookup(qname)
        prefix, id = qname.to_s.split(":", 2)
        return nil unless id

        dict = load_by_prefix(prefix)
        return nil unless dict

        dict.lookup(qname)
      end

      def self.lookup!(qname)
        lookup(qname) || raise(KeyError, "no dictionary entry #{qname.inspect}")
      end

      def self.load_builtin(name)
        @mutex.synchronize do
          @cache[name.to_s] ||= begin
            path = File.join(Chemicalml::Dictionary::BUILTIN_DIR, "#{name}.yaml")
            raise KeyError, "no built-in dictionary #{name.inspect}" unless File.exist?(path)

            Loader.from_file(path)
          end
        end
      end

      def self.load_by_prefix(prefix)
        manifest.each do |name, info|
          return load_builtin(name) if info["prefix"] == prefix
        end
        nil
      end

      def self.reset!
        @mutex.synchronize { @cache.clear }
      end

      def self.builtin_names
        Dir.glob(File.join(BUILTIN_DIR, "*.yaml"))
           .reject { |p| File.basename(p).start_with?("_") }
           .map { |p| File.basename(p, ".yaml").to_sym }
           .sort
      end

      def self.manifest
        @manifest ||= begin
          path = File.join(BUILTIN_DIR, "_index.yaml")
          if File.exist?(path)
            YAML.load_file(path) || {}
          else
            builtin_names.each_with_object({}) do |name, h|
              h[name.to_s] = { "prefix" => name.to_s }
            end
          end
        end
      end
      private_class_method :manifest

      require "yaml"
    end
  end
end
