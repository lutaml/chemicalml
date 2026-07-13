# frozen_string_literal: true

module Chemicalml
  module Convention
    # Lookup table for conventions. Built-in conventions are
    # registered lazily on first access to avoid load-order surprises.
    #
    # Adding a new convention = creating a subclass of `Base` that
    # returns its QName and namespace_uri, then registering it here.
    # No switch statements, no if/elsif chains in framework code.
    module Registry
      @mutex = Mutex.new
      @cache = nil

      def self.lookup(qname)
        load_cache[qname.to_s]
      end

      def self.validate(document, qname:)
        convention = lookup(qname)
        raise ArgumentError, "unknown convention: #{qname.inspect}" unless convention

        convention.validate(document)
      end

      def self.builtin_qnames
        load_cache.keys.sort
      end

      def self.reset!
        @mutex.synchronize { @cache = nil }
      end

      def self.load_cache
        @mutex.synchronize do
          @cache ||= begin
            {
              Molecular.qname            => Molecular,
              Compchem.qname             => Compchem,
              Dictionary.qname           => Dictionary,
              UnitDictionary.qname       => UnitDictionary,
              UnitTypeDictionary.qname   => UnitTypeDictionary
            }
          end
        end
      end
      private_class_method :load_cache
    end
  end
end
