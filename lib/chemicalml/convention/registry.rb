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

      def self.validate_report(document, qname:)
        convention = lookup(qname)
        raise ArgumentError, "unknown convention: #{qname.inspect}" unless convention

        convention.validate_report(document)
      end

      # Detect the convention from the document's root `convention`
      # attribute and validate. Raises ArgumentError if the document
      # declares no convention or an unknown one.
      def self.detect_and_validate(document)
        qname = Convention::Detection.convention_of(document)
        raise ArgumentError, 'document declares no convention attribute' unless qname

        validate_report(document, qname: qname)
      end

      def self.builtin_qnames
        load_cache.keys.sort
      end

      # Iterate every registered convention. Yields the convention
      # module. Enumerable-style: returns an Enumerator if no block.
      #
      # @yield [Module] each convention module.
      # @return [Array<Module>, Enumerator] the conventions if a
      #   block is given; otherwise an Enumerator.
      def self.each(&)
        return to_enum(:each) unless block_given?

        load_cache.values.sort_by(&:qname).each(&)
      end

      # Iterate every constraint across every convention. Yields
      # (convention, constraint_class) pairs. Useful for documentation
      # generation and code introspection.
      #
      # @yieldparam convention [Module] the convention module.
      # @yieldparam constraint [Class] the constraint class.
      # @return [Enumerator, Integer] count if block given; otherwise
      #   an Enumerator.
      def self.each_constraint(&)
        return to_enum(:each_constraint) unless block_given?

        count = 0
        each do |conv|
          conv.constraints.each do |constraint|
            yield(conv, constraint)
            count += 1
          end
        end
        count
      end

      # Total count of registered constraints across all conventions.
      def self.total_constraint_count
        each.sum(&:constraint_count)
      end

      # True if a document with the given Role could carry a
      # convention attribute that Detection would recognise.
      #
      # @param role [Module] a Role::* module.
      # @return [Boolean]
      def self.convention_root?(role)
        Detection::CONVENTION_ROOTS.any? { |r| role <= r }
      rescue StandardError
        Detection::CONVENTION_ROOTS.include?(role)
      end

      # Register a custom convention at runtime. The convention module
      # must extend `Chemicalml::Convention::Base` and implement
      # `qname` and `namespace_uri`.
      #
      # @param mod [Module] the convention module (must `extend Base`).
      # @return [Module] the registered module.
      # @raise [ArgumentError] if `mod.qname` is nil/empty.
      def self.register_custom(mod)
        qname = mod.qname
        raise ArgumentError, 'convention module must return a non-empty qname' if qname.nil? || qname.to_s.empty?

        # Force load_cache to populate (acquires/releases mutex internally),
        # then mutate directly without re-entering the mutex.
        cache = load_cache
        cache[qname.to_s] = mod
        mod
      end

      def self.reset!
        @mutex.synchronize { @load_cache = nil }
      end

      def self.load_cache
        @mutex.synchronize do
          @load_cache ||= {
            Molecular.qname => Molecular,
            Compchem.qname => Compchem,
            Dictionary.qname => Dictionary,
            UnitDictionary.qname => UnitDictionary,
            UnitTypeDictionary.qname => UnitTypeDictionary,
            Spectroscopy.qname => Spectroscopy,
            Cascade.qname => Cascade,
            SimpleUnit.qname => SimpleUnit
          }
        end
      end
      private_class_method :load_cache
    end
  end
end
