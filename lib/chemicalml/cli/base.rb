# frozen_string_literal: true

require "thor"

module Chemicalml
  module Cli
    # Thor-based dispatcher. Each command delegates to a dedicated
    # `Chemicalml::Cli::*Command` class invoked as
    # `MyCommand.new.run(options)`, where `options` is a single hash
    # carrying both positional args (keyed by name) and flags.
    #
    # Adding a new command:
    #   1. Create `lib/chemicalml/cli/<name>_command.rb` extending
    #      `Chemicalml::Cli::Command` with a `#run(options)` method.
    #   2. Add one `desc + method_option + def` block below that
    #      builds the options hash and calls `<Name>Command.new.run(hash)`.
    class Base < Thor
      desc "validate FILE", "Validate a CML file against its declared convention"
      method_option :json, type: :boolean, aliases: "-j",
                            desc: "Emit machine-readable JSON output"
      def validate(file)
        ValidateCommand.new.run(file: file, json: options[:json])
      end

      desc "inspect FILE", "Print a tree-style summary of the document"
      def inspect(file)
        InspectCommand.new.run(file: file)
      end

      desc "conventions", "List registered conventions"
      def conventions
        ConventionsCommand.new.run({})
      end

      desc "dictionaries", "List built-in dictionaries"
      def dictionaries
        DictionariesCommand.new.run({})
      end

      desc "elements", "List all CML wire classes"
      def elements
        ElementsCommand.new.run({})
      end

      desc "constraints", "List all registered constraints"
      def constraints
        ConstraintsCommand.new.run({})
      end

      desc "enums", "List all XSD enum constants"
      def enums
        EnumsCommand.new.run({})
      end

      desc "info ELEMENT", "Show details about a CML element"
      def info(element)
        InfoCommand.new.run(element: element)
      end
    end
  end
end
