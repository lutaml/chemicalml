# frozen_string_literal: true

module Chemicalml
  # CML model layer. The wire classes live under `Schema3::` and
  # `Schema24::` namespaces; the top-level `Cml::*` constants are
  # backward-compatible aliases pointing at the Schema3 versions.
  # Shared attribute + xml-mapping declarations live under `Base::*`
  # and are included by both schema-versioned class hierarchies.
  module Cml
    # Structural modules (each in its own file, loaded independently).
    autoload :Base,                'chemicalml/cml/base'
    autoload :CanonicalComparison, 'chemicalml/cml/canonical_comparison'
    autoload :Elements,            'chemicalml/cml/elements'
    autoload :Enums,             'chemicalml/cml/enums'
    autoload :Namespace,         'chemicalml/cml/namespace'
    autoload :Patterns,          'chemicalml/cml/patterns'
    autoload :ReferenceResolver, 'chemicalml/cml/reference_resolver'
    autoload :Role,              'chemicalml/cml/role'
    autoload :Schema3,           'chemicalml/cml/schema3'
    autoload :Schema24,          'chemicalml/cml/schema24'
    autoload :Visitable,         'chemicalml/cml/visitable'
    autoload :WireClassRegistry, 'chemicalml/cml/wire_class_registry'

    class << self
      # Look up a wire class by XML element name.
      #
      # @param xml_name [String, Symbol] the XML element name, e.g. "atomArray".
      # @param schema [Symbol] `:schema3` (default) or `:schema24`.
      # @return [Class, nil] the matching wire class, or nil if not found.
      def for_xml_name(xml_name, schema: :schema3)
        class_name = Elements::XML_TO_CLASS[xml_name.to_s]
        return nil unless class_name

        parent = schema == :schema24 ? Schema24 : Schema3
        parent.const_get(class_name)
      rescue NameError
        nil
      end

      # Enumerate every wire class for a schema version.
      #
      # @param schema [Symbol] `:schema3` or `:schema24`.
      # @return [Array<Class>] the wire classes.
      def wire_classes(schema: :schema3)
        parent = schema == :schema24 ? Schema24 : Schema3
        Elements::ALL.keys.map do |class_name|
          parent.const_get(class_name)
        rescue NameError
          nil
        end.compact
      end
    end

    # Backward-compatible aliases (Cml::Foo = Schema3::Foo). All 121
    # aliases load from a single file via autoload — the file loads
    # lazily when the first alias is referenced, then defines all of
    # them via const_set (aliasing existing Schema3 classes, not
    # creating new ones).
    autoload :Array,           'chemicalml/cml/aliases'
    autoload :Atom,            'chemicalml/cml/aliases'
    autoload :AtomArray,       'chemicalml/cml/aliases'
    autoload :AtomParity,      'chemicalml/cml/aliases'
    autoload :Bond,            'chemicalml/cml/aliases'
    autoload :BondArray,       'chemicalml/cml/aliases'
    autoload :BondStereo,      'chemicalml/cml/aliases'
    autoload :Dictionary,      'chemicalml/cml/aliases'
    autoload :DictionaryEntry, 'chemicalml/cml/aliases'
    autoload :Document,        'chemicalml/cml/aliases'
    autoload :Formula,         'chemicalml/cml/aliases'
    autoload :Identifier,      'chemicalml/cml/aliases'
    autoload :Label,           'chemicalml/cml/aliases'
    autoload :List,            'chemicalml/cml/aliases'
    autoload :Matrix,          'chemicalml/cml/aliases'
    autoload :Metadata,        'chemicalml/cml/aliases'
    autoload :MetadataList,    'chemicalml/cml/aliases'
    autoload :Module,          'chemicalml/cml/aliases'
    autoload :Molecule,        'chemicalml/cml/aliases'
    autoload :Name,            'chemicalml/cml/aliases'
    autoload :Parameter,       'chemicalml/cml/aliases'
    autoload :ParameterList,   'chemicalml/cml/aliases'
    autoload :Product,         'chemicalml/cml/aliases'
    autoload :ProductList,     'chemicalml/cml/aliases'
    autoload :Property,        'chemicalml/cml/aliases'
    autoload :PropertyList,    'chemicalml/cml/aliases'
    autoload :Reaction,        'chemicalml/cml/aliases'
    autoload :ReactionList,    'chemicalml/cml/aliases'
    autoload :Reactant,        'chemicalml/cml/aliases'
    autoload :ReactantList,    'chemicalml/cml/aliases'
    autoload :Scalar,          'chemicalml/cml/aliases'
    autoload :Substance,       'chemicalml/cml/aliases'
    autoload :Unit,            'chemicalml/cml/aliases'
    autoload :UnitList,        'chemicalml/cml/aliases'
    autoload :UnitType,        'chemicalml/cml/aliases'
    autoload :UnitTypeList,    'chemicalml/cml/aliases'
    autoload :Abundance, 'chemicalml/cml/aliases'
    autoload :Action, 'chemicalml/cml/aliases'
    autoload :ActionList, 'chemicalml/cml/aliases'
    autoload :Amount, 'chemicalml/cml/aliases'
    autoload :Angle, 'chemicalml/cml/aliases'
    autoload :AnyCml, 'chemicalml/cml/aliases'
    autoload :ArrayList, 'chemicalml/cml/aliases'
    autoload :AtomSet, 'chemicalml/cml/aliases'
    autoload :AtomType, 'chemicalml/cml/aliases'
    autoload :AtomTypeList, 'chemicalml/cml/aliases'
    autoload :AtomicBasisFunction, 'chemicalml/cml/aliases'
    autoload :Band, 'chemicalml/cml/aliases'
    autoload :BandList, 'chemicalml/cml/aliases'
    autoload :BasisSet, 'chemicalml/cml/aliases'
    autoload :BondSet, 'chemicalml/cml/aliases'
    autoload :BondType, 'chemicalml/cml/aliases'
    autoload :BondTypeList, 'chemicalml/cml/aliases'
    autoload :CellParameter, 'chemicalml/cml/aliases'
    autoload :ConditionList, 'chemicalml/cml/aliases'
    autoload :Crystal, 'chemicalml/cml/aliases'
    autoload :Definition, 'chemicalml/cml/aliases'
    autoload :Description, 'chemicalml/cml/aliases'
    autoload :Dimension, 'chemicalml/cml/aliases'
    autoload :Documentation, 'chemicalml/cml/aliases'
    autoload :Eigen, 'chemicalml/cml/aliases'
    autoload :Electron, 'chemicalml/cml/aliases'
    autoload :Fragment, 'chemicalml/cml/aliases'
    autoload :FragmentList, 'chemicalml/cml/aliases'
    autoload :Gradient, 'chemicalml/cml/aliases'
    autoload :Isotope, 'chemicalml/cml/aliases'
    autoload :IsotopeList, 'chemicalml/cml/aliases'
    autoload :Join, 'chemicalml/cml/aliases'
    autoload :Kpoint, 'chemicalml/cml/aliases'
    autoload :KpointList, 'chemicalml/cml/aliases'
    autoload :Lattice, 'chemicalml/cml/aliases'
    autoload :LatticeVector, 'chemicalml/cml/aliases'
    autoload :Length, 'chemicalml/cml/aliases'
    autoload :Line3, 'chemicalml/cml/aliases'
    autoload :Link, 'chemicalml/cml/aliases'
    autoload :Map, 'chemicalml/cml/aliases'
    autoload :Mechanism, 'chemicalml/cml/aliases'
    autoload :MechanismComponent, 'chemicalml/cml/aliases'
    autoload :MoleculeList, 'chemicalml/cml/aliases'
    autoload :Object, 'chemicalml/cml/aliases'
    autoload :Observation, 'chemicalml/cml/aliases'
    autoload :Particle, 'chemicalml/cml/aliases'
    autoload :Peak, 'chemicalml/cml/aliases'
    autoload :PeakGroup, 'chemicalml/cml/aliases'
    autoload :PeakList, 'chemicalml/cml/aliases'
    autoload :PeakStructure, 'chemicalml/cml/aliases'
    autoload :Plane3, 'chemicalml/cml/aliases'
    autoload :Point3, 'chemicalml/cml/aliases'
    autoload :Potential, 'chemicalml/cml/aliases'
    autoload :PotentialForm, 'chemicalml/cml/aliases'
    autoload :PotentialList, 'chemicalml/cml/aliases'
    autoload :ReactionScheme, 'chemicalml/cml/aliases'
    autoload :ReactionStep, 'chemicalml/cml/aliases'
    autoload :ReactionStepList, 'chemicalml/cml/aliases'
    autoload :ReactiveCentre, 'chemicalml/cml/aliases'
    autoload :Region, 'chemicalml/cml/aliases'
    autoload :Sample, 'chemicalml/cml/aliases'
    autoload :Spectator, 'chemicalml/cml/aliases'
    autoload :SpectatorList, 'chemicalml/cml/aliases'
    autoload :Spectrum, 'chemicalml/cml/aliases'
    autoload :SpectrumData, 'chemicalml/cml/aliases'
    autoload :SpectrumList, 'chemicalml/cml/aliases'
    autoload :Sphere3, 'chemicalml/cml/aliases'
    autoload :Stmml, 'chemicalml/cml/aliases'
    autoload :SubstanceList, 'chemicalml/cml/aliases'
    autoload :Symmetry, 'chemicalml/cml/aliases'
    autoload :System, 'chemicalml/cml/aliases'
    autoload :Table, 'chemicalml/cml/aliases'
    autoload :TableCell, 'chemicalml/cml/aliases'
    autoload :TableContent, 'chemicalml/cml/aliases'
    autoload :TableHeader, 'chemicalml/cml/aliases'
    autoload :TableHeaderCell, 'chemicalml/cml/aliases'
    autoload :TableRow, 'chemicalml/cml/aliases'
    autoload :TableRowList, 'chemicalml/cml/aliases'
    autoload :Torsion, 'chemicalml/cml/aliases'
    autoload :Transform3, 'chemicalml/cml/aliases'
    autoload :TransitionState, 'chemicalml/cml/aliases'
    autoload :Vector3, 'chemicalml/cml/aliases'
    autoload :Xaxis, 'chemicalml/cml/aliases'
    autoload :Yaxis, 'chemicalml/cml/aliases'
    autoload :ZMatrix, 'chemicalml/cml/aliases'
  end
end
