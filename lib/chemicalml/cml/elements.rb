# frozen_string_literal: true

module Chemicalml
  module Cml
    # Single source of truth for the set of CML element wire classes
    # each schema version must register. Adding a new CML element =
    # adding one entry to `ALL`. Both `Schema3::Configuration` and
    # `Schema24::Configuration` walk this list.
    module Elements
      ALL = {
        # Originally modeled elements
        Array: :array,
        Atom: :atom,
        AtomArray: :atomArray,
        AtomParity: :atomParity,
        Bond: :bond,
        BondArray: :bondArray,
        BondStereo: :bondStereo,
        Dictionary: :dictionary,
        DictionaryEntry: :entry,
        Document: :document,
        Formula: :formula,
        Identifier: :identifier,
        Label: :label,
        List: :list,
        Matrix: :matrix,
        Metadata: :metadata,
        MetadataList: :metadataList,
        Module: :module,
        Molecule: :molecule,
        Name: :name,
        Parameter: :parameter,
        ParameterList: :parameterList,
        Product: :product,
        ProductList: :productList,
        Property: :property,
        PropertyList: :propertyList,
        Reaction: :reaction,
        ReactionList: :reactionList,
        Reactant: :reactant,
        ReactantList: :reactantList,
        Scalar: :scalar,
        Substance: :substance,
        Unit: :unit,
        UnitList: :unitList,
        UnitType: :unitType,
        UnitTypeList: :unitTypeList,
        # Full schema coverage — every CML element from the XSD
        Abundance: :abundance,
        Action: :action,
        ActionList: :actionList,
        Amount: :amount,
        Angle: :angle,
        AnyCml: :anyCml,
        ArrayList: :arrayList,
        AtomSet: :atomSet,
        AtomType: :atomType,
        AtomTypeList: :atomTypeList,
        AtomicBasisFunction: :atomicBasisFunction,
        Band: :band,
        BandList: :bandList,
        BasisSet: :basisSet,
        BondSet: :bondSet,
        BondType: :bondType,
        BondTypeList: :bondTypeList,
        CellParameter: :cellParameter,
        ConditionList: :conditionList,
        Crystal: :crystal,
        Definition: :definition,
        Description: :description,
        Dimension: :dimension,
        Documentation: :documentation,
        Eigen: :eigen,
        Electron: :electron,
        Fragment: :fragment,
        FragmentList: :fragmentList,
        Gradient: :gradient,
        Isotope: :isotope,
        IsotopeList: :isotopeList,
        Join: :join,
        Kpoint: :kpoint,
        KpointList: :kpointList,
        Lattice: :lattice,
        LatticeVector: :latticeVector,
        Length: :length,
        Line3: :line3,
        Link: :link,
        Map: :map,
        Mechanism: :mechanism,
        MechanismComponent: :mechanismComponent,
        MoleculeList: :moleculeList,
        Object: :object,
        Observation: :observation,
        Particle: :particle,
        Peak: :peak,
        PeakGroup: :peakGroup,
        PeakList: :peakList,
        PeakStructure: :peakStructure,
        Plane3: :plane3,
        Point3: :point3,
        Potential: :potential,
        PotentialForm: :potentialForm,
        PotentialList: :potentialList,
        ReactionScheme: :reactionScheme,
        ReactionStep: :reactionStep,
        ReactionStepList: :reactionStepList,
        ReactiveCentre: :reactiveCentre,
        Region: :region,
        Sample: :sample,
        Spectator: :spectator,
        SpectatorList: :spectatorList,
        Spectrum: :spectrum,
        SpectrumData: :spectrumData,
        SpectrumList: :spectrumList,
        Sphere3: :sphere3,
        Stmml: :stmml,
        SubstanceList: :substanceList,
        Symmetry: :symmetry,
        System: :system,
        Table: :table,
        TableCell: :tableCell,
        TableContent: :tableContent,
        TableHeader: :tableHeader,
        TableHeaderCell: :tableHeaderCell,
        TableRow: :tableRow,
        TableRowList: :tableRowList,
        Torsion: :torsion,
        Transform3: :transform3,
        TransitionState: :transitionState,
        Vector3: :vector3,
        Xaxis: :xaxis,
        Yaxis: :yaxis,
        ZMatrix: :zMatrix
      }.freeze

      # Elements declared in the Schema 3 XSD but absent from the
      # Schema 2.4 XSD. Verified by diffing the actual XSDs in
      # `reference-docs/schemas/`: Schema 3 declares `<anyCml>` while
      # Schema 2.4 does not. Conversely, Schema 2.4 declares 17 legacy
      # elements (`alternative`, `annotation`, `appinfo`, `arg`,
      # `complexObject`, `enumeration`, `expression`, `float`,
      # `floatArray`, `integer`, `integerArray`, `operator`,
      # `relatedEntry`, `string`, `stringArray`, `tcell`, `trow`) that
      # are either redundant with Schema 3's unified types or outside
      # the gem's scope.
      SCHEMA3_ONLY = %i[AnyCml].freeze

      # Subset of the Schema-2.4-only legacy elements that the gem
      # explicitly models. Maps Ruby class name → XML element id so
      # `Schema24::Configuration` can register them without polluting
      # `Elements::ALL` (which mirrors Schema 3's element set).
      SCHEMA24_ONLY = {
        Alternative: :alternative,
        Annotation: :annotation,
        Appinfo: :appinfo,
        Arg: :arg,
        ComplexObject: :complexObject,
        Enumeration: :enumeration,
        Expression: :expression,
        Float: :float,
        FloatArray: :floatArray,
        Integer: :integer,
        IntegerArray: :integerArray,
        Operator: :operator,
        RelatedEntry: :relatedEntry,
        String: :string,
        StringArray: :stringArray,
        Tcell: :tcell,
        Trow: :trow
      }.freeze

      # Schema24-only elements whose XML element id collides with a
      # lutaml-model primitive type name (`:string`, `:integer`,
      # `:float`). Registering them as types would shadow the
      # primitive, breaking every `attribute :foo, :string` cast.
      # They remain defined as wire classes and parseable as roots,
      # but `register_elements!` skips registering them in the
      # schema24 type context.
      SCHEMA24_TYPE_COLLISIONS = %i[Float Integer String].freeze

      # Reverse index: XML element name (String) → Ruby class name
      # (Symbol). O(1) lookup for VersionedParser root detection.
      # Includes both Schema 3 elements and the modeled Schema 2.4
      # legacy elements.
      XML_TO_CLASS = [ALL, SCHEMA24_ONLY].each_with_object({}) do |src, h|
        src.each { |cls, xml_id| h[xml_id.to_s] = cls }
      end.freeze
    end
  end
end
