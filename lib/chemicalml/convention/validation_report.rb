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

        raise ArgumentError, "cannot combine ValidationReport with #{other.class}" unless other.is_a?(ValidationReport)

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

      # Human-readable multi-line summary. Suitable for CLI output
      # and logging. Each violation is rendered with severity, path,
      # and message (and value when present).
      #
      # @return [String]
      def summary
        return 'OK — no violations' if ok? && !has_warnings?

        lines = []
        lines << "Errors: #{errors.size}, Warnings: #{warnings.size}"
        unless errors.empty?
          lines << ''
          lines << 'Errors:'
          errors.each { |v| lines << "  ERROR #{v.path}: #{v.message}#{value_suffix(v)}" }
        end
        unless warnings.empty?
          lines << ''
          lines << 'Warnings:'
          warnings.each { |v| lines << "  WARN  #{v.path}: #{v.message}#{value_suffix(v)}" }
        end
        lines.join("\n")
      end

      private

      def value_suffix(violation)
        violation.value.nil? ? '' : " (value=#{violation.value.inspect})"
      end
    end
  end
end
