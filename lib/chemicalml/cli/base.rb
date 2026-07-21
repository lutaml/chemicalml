# frozen_string_literal: true

require 'thor'

module Chemicalml
  module Cli
    # Thor-based dispatcher. Each command delegates to a dedicated
    # `Chemicalml::Cli::*Command` class invoked as
    # `MyCommand.new.run(options)`, where `options` is a single hash
    # carrying both positional args (keyed by name) and flags.
    #
    # A `Chemicalml::Logger` bridged to Thor's shell is injected into
    # every command — so info/warn/error get coloured output on the
    # terminal while remaining loggable for library callers.
    class Base < Thor
      private

      # Build a logger bridged to this Thor instance for coloured output.
      def bridged_logger
        Chemicalml::Logger.default.tap { |l| l.thor_shell = self }
      end

      public

      desc 'validate FILE', 'Validate a CML file against its declared convention'
      method_option :json, type: :boolean, aliases: '-j',
                           desc: 'Emit machine-readable JSON output'
      def validate(file)
        ValidateCommand.new(logger: bridged_logger).run(file: file, json: options[:json])
      end

      desc 'inspect FILE', 'Print a tree-style summary of the document'
      def inspect(file)
        InspectCommand.new(logger: bridged_logger).run(file: file)
      end

      desc 'conventions', 'List registered conventions'
      def conventions
        ConventionsCommand.new(logger: bridged_logger).run({})
      end

      desc 'dictionaries', 'List built-in dictionaries'
      def dictionaries
        DictionariesCommand.new(logger: bridged_logger).run({})
      end

      desc 'elements', 'List all CML wire classes'
      def elements
        ElementsCommand.new(logger: bridged_logger).run({})
      end

      desc 'constraints', 'List all registered constraints'
      def constraints
        ConstraintsCommand.new(logger: bridged_logger).run({})
      end

      desc 'enums', 'List all XSD enum constants'
      def enums
        EnumsCommand.new(logger: bridged_logger).run({})
      end

      desc 'info ELEMENT', 'Show details about a CML element'
      def info(element)
        InfoCommand.new(logger: bridged_logger).run(element: element)
      end
    end
  end
end
