# frozen_string_literal: true

module Chemicalml
  module Convention
    # Value object wrapping the violations returned by `validate`.
    # Gives callers severity-based views without losing the raw array
    # (still exposed as `#violations`).
    #
    # Constructed by `Convention.validate_report` (new API) —
    # `Convention.validate` keeps its array return shape so existing
    # callers don't break.
    class ValidationReport
      attr_reader :violations

      def initialize(violations)
        @violations = violations.to_a.freeze
      end

      def errors
        @errors ||= violations.select(&:error?).freeze
      end

      def warnings
        @warnings ||= violations.select(&:warning?).freeze
      end

      def ok?
        errors.empty?
      end

      def has_warnings?
        warnings.any?
      end

      def size
        violations.length
      end

      def +(other)
        return other if other.nil?

        unless other.is_a?(ValidationReport)
          raise ArgumentError, "cannot combine ValidationReport with #{other.class}"
        end

        ValidationReport.new(violations + other.violations)
      end

      def ==(other)
        other.is_a?(ValidationReport) && violations == other.violations
      end
      alias eql? ==

      def hash
        violations.hash
      end

      def to_s
        "#{size} violation(s): #{errors.length} error(s), #{warnings.length} warning(s)"
      end
    end
  end
end
