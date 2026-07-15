# frozen_string_literal: true

module Chemicalml
  # Convention framework. A convention is a named, namespaced set of
  # constraints that CML documents conform to in a particular domain.
  #
  # Conventions are *registered*, not switch-statement'd. Each
  # convention owns its constraint classes; the framework walks
  # whatever was registered.
  #
  # The five built-in conventions:
  #
  #   molecular            http://www.xml-cml.org/convention/molecular
  #   compchem             http://www.xml-cml.org/convention/compchem
  #   dictionary           http://www.xml-cml.org/convention/dictionary
  #   unit-dictionary      http://www.xml-cml.org/convention/unit-dictionary
  #   unitType-dictionary  http://www.xml-cml.org/convention/unitType-dictionary
  module Convention
    autoload :Base,                "chemicalml/convention/base"
    autoload :Compchem,            "chemicalml/convention/compchem"
    autoload :Constraint,          "chemicalml/convention/constraint"
    autoload :Coordinator,         "chemicalml/convention/coordinator"
    autoload :Detection,           "chemicalml/convention/detection"
    autoload :Dictionary,          "chemicalml/convention/dictionary"
    autoload :Molecular,           "chemicalml/convention/molecular"
    autoload :Registry,            "chemicalml/convention/registry"
    autoload :UnitDictionary,      "chemicalml/convention/unit_dictionary"
    autoload :UnitTypeDictionary,  "chemicalml/convention/unit_type_dictionary"
    autoload :ValidationReport,    "chemicalml/convention/validation_report"
    autoload :Violation,           "chemicalml/convention/violation"

    CONVENTION_NAMESPACE = "http://www.xml-cml.org/convention/".freeze

    def self.lookup(qname)
      Registry.lookup(qname)
    end

    def self.validate(document, qname:)
      Registry.validate(document, qname: qname)
    end

    def self.validate_report(document, qname:)
      Registry.validate_report(document, qname: qname)
    end

    def self.detect_and_validate(document)
      Registry.detect_and_validate(document)
    end
  end
end
