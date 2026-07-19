# frozen_string_literal: true

module Chemicalml
  # Command-line interface. Built on Thor for dispatch; each command is
  # a dedicated class under `Chemicalml::Cli::*Command` exposing
  # `.run(args, options)` (and `#run` on an instance).
  #
  # Dispatch flow:
  #
  #   exe/chemicalml ARGV
  #     -> Chemicalml::Cli::Base.start(ARGV)  (Thor)
  #     -> Chemicalml::Cli::<Name>Command.new.run(args, options)
  #
  # Adding a new command:
  #   1. Create `lib/chemicalml/cli/<name>_command.rb` with a class
  #      extending `Chemicalml::Cli::Command` and implementing `#run`.
  #   2. Add one `desc + def` block in `Chemicalml::Cli::Base` that
  #      invokes `<Name>Command.new.run(args, options)`.
  #   3. Add the autoload entry below.
  module Cli
    autoload :Base,           "chemicalml/cli/base"
    autoload :Command,        "chemicalml/cli/command"
    autoload :ValidateCommand,    "chemicalml/cli/validate_command"
    autoload :InspectCommand,     "chemicalml/cli/inspect_command"
    autoload :ConventionsCommand, "chemicalml/cli/conventions_command"
    autoload :DictionariesCommand, "chemicalml/cli/dictionaries_command"
    autoload :ElementsCommand,    "chemicalml/cli/elements_command"
    autoload :ConstraintsCommand, "chemicalml/cli/constraints_command"
    autoload :EnumsCommand,       "chemicalml/cli/enums_command"
    autoload :InfoCommand,        "chemicalml/cli/info_command"

    # Backward-compatible entry point used by `exe/chemicalml` and tests.
    # @param argv [Array<String>] the command line.
    # @return [Integer] process exit code.
    def self.run(argv)
      Base.start(argv)
      0
    rescue StandardError => e
      warn "FAIL: #{e.message}"
      2
    end
  end
end
