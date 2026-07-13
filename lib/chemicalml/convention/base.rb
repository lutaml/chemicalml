# frozen_string_literal: true

module Chemicalml
  module Convention
    # Mixin that gives a convention module its registry behavior:
    #
    #   - `qname` / `namespace_uri` (must be implemented by the host)
    #   - `constraints` (lazy array)
    #   - `register(SomeConstraintClass)`
    #   - `validate(document)` -> [Violation, ...]
    #
    # The framework never inspects which constraints a convention has;
    # it just walks whatever was registered. Adding a new rule = a new
    # constraint subclass + a `register` call.
    module Base
      def qname
        raise NotImplementedError, "#{name} must define its QName"
      end

      def namespace_uri
        raise NotImplementedError, "#{name} must define its namespace URI"
      end

      def constraints
        @constraints ||= []
      end

      def register(constraint_class)
        constraints << constraint_class unless constraints.include?(constraint_class)
        self
      end

      def validate(document)
        constraints.flat_map do |klass|
          klass.new.check(document)
        end
      end

      def constraint_count
        constraints.length
      end

      def reset_constraints!
        @constraints = []
      end
    end
  end
end
