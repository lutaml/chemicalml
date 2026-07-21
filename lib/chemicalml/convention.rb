# frozen_string_literal: true

module Chemicalml
  # Convention framework. A convention is a named, namespaced set of
  # constraints that CML documents conform to in a particular domain.
  #
  # Conventions are *registered*, not switch-statement'd. Each
  # convention owns its constraint classes; the framework walks
  # whatever was registered.
  #
  # The built-in conventions:
  #
  #   molecular            http://www.xml-cml.org/convention/molecular
  #   compchem             http://www.xml-cml.org/convention/compchem
  #   dictionary           http://www.xml-cml.org/convention/dictionary
  #   unit-dictionary      http://www.xml-cml.org/convention/unit-dictionary
  #   unitType-dictionary  http://www.xml-cml.org/convention/unitType-dictionary
  #   spectroscopy         http://www.xml-cml.org/convention/spectroscopy
  #   cascade              http://www.xml-cml.org/convention/cascade
  #   simpleUnit           http://www.xml-cml.org/convention/simpleUnit
  module Convention
    autoload :Base,                'chemicalml/convention/base'
    autoload :Cascade,             'chemicalml/convention/cascade'
    autoload :Compchem,            'chemicalml/convention/compchem'
    autoload :Constraint,          'chemicalml/convention/constraint'
    autoload :Coordinator,         'chemicalml/convention/coordinator'
    autoload :Detection,           'chemicalml/convention/detection'
    autoload :Dictionary,          'chemicalml/convention/dictionary'
    autoload :Molecular,           'chemicalml/convention/molecular'
    autoload :Registry,            'chemicalml/convention/registry'
    autoload :SimpleUnit,          'chemicalml/convention/simple_unit'
    autoload :Spectroscopy,        'chemicalml/convention/spectroscopy'
    autoload :UnitDictionary,      'chemicalml/convention/unit_dictionary'
    autoload :UnitTypeDictionary,  'chemicalml/convention/unit_type_dictionary'
    autoload :ValidationReport,    'chemicalml/convention/validation_report'
    autoload :Violation,           'chemicalml/convention/violation'

    CONVENTION_NAMESPACE = 'http://www.xml-cml.org/convention/'

    # Look up a convention by QName (e.g. "convention:molecular").
    # @param qname [String] the convention QName.
    # @return [Module, nil] the convention module, or nil if unknown.
    def self.lookup(qname)
      Registry.lookup(qname)
    end

    # Validate a document against a named convention. Returns the
    # raw violation list.
    #
    # @param document [Lutaml::Model::Serializable] the CML document.
    # @param qname [String] the convention QName (e.g. "convention:molecular").
    # @return [Array<Chemicalml::Convention::Violation>] the violations.
    # @raise [ArgumentError] if the qname is not registered.
    def self.validate(document, qname:)
      Registry.validate(document, qname: qname)
    end

    # Validate and return a structured report (errors + warnings).
    #
    # @param document [Lutaml::Model::Serializable] the CML document.
    # @param qname [String] the convention QName.
    # @return [Chemicalml::Convention::ValidationReport] the report.
    def self.validate_report(document, qname:)
      Registry.validate_report(document, qname: qname)
    end

    # Auto-detect the convention from the document root's `convention`
    # attribute and validate.
    #
    # @param document [Lutaml::Model::Serializable] the CML document.
    # @return [Chemicalml::Convention::ValidationReport] the report.
    # @raise [ArgumentError] if no convention is declared.
    def self.detect_and_validate(document)
      Registry.detect_and_validate(document)
    end
  end
end
