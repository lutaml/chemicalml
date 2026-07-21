# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml validate <file>` — auto-detect convention and
    # print violations. With `--json` / `-j`, emits machine-readable
    # JSON.
    class ValidateCommand < Command
      def run(options)
        path = options[:file]
        unless path
          logger.error 'validate requires a <file> argument'
          return 2
        end

        logger.info "Validating #{path}" unless options[:json]
        doc = Chemicalml.parse(File.read(path), schema: :schema3)
        report = Chemicalml.validate(doc)

        if options[:json]
          puts json_report(report, path)
        elsif report.ok? && !report.has_warnings?
          logger.info "OK: #{path}"
        else
          logger.error report.summary
        end
        report.ok? ? 0 : 1
      rescue ArgumentError, Lutaml::Model::InvalidFormatError => e
        logger.error "FAIL: #{e.message}"
        2
      end

      private

      def json_report(report, path)
        require 'json'
        payload = {
          file: path,
          ok: report.ok?,
          has_warnings: report.has_warnings?,
          violations: report.violations.map do |v|
            {
              severity: v.severity,
              path: v.path,
              message: v.message,
              value: v.value
            }.compact
          end
        }
        JSON.pretty_generate(payload)
      end
    end
  end
end
