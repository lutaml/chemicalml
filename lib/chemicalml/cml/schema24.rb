# frozen_string_literal: true

module Chemicalml
  module Cml
    # Schema 2.4 wire classes. Same structure as Schema3 — each is a
    # `Lutaml::Model::Serializable` subclass that includes the
    # `Base::*` mixin and `Visitable`, and `extend`s
    # `Schema24::Context` for `lutaml_default_register`.
    #
    # Schema 2.4 wire classes. Same structure as Schema3 — each is a
    # `Lutaml::Model::Serializable` subclass that includes the
    # `Base::*` mixin and `Visitable`, and `extend`s
    # `Schema24::Context` for `lutaml_default_register`.
    #
    # Schema 2.4 lacks `<anyCml>` (Schema 3 only — see
    # `Chemicalml::Cml::Elements::SCHEMA3_ONLY`). Every other element
    # modeled here is declared in the Schema 2.4 XSD, including
    # `<module>`. Schema 2.4 also declares 17 legacy elements not in
    # Schema 3 (`alternative`, `annotation`, `appinfo`, `arg`,
    # `complexObject`, `enumeration`, `expression`, `float`,
    # `floatArray`, `integer`, `integerArray`, `operator`,
    # `relatedEntry`, `string`, `stringArray`, `tcell`, `trow`); all
    # are modeled under Schema24 only and registered via
    # `Elements::SCHEMA24_ONLY`.
    module Schema24
      extend Chemicalml::VersionedParser

      autoload :Abundance, "chemicalml/cml/schema24/abundance"
      autoload :Action, "chemicalml/cml/schema24/action"
      autoload :ActionList, "chemicalml/cml/schema24/action_list"
      autoload :Amount, "chemicalml/cml/schema24/amount"
      autoload :Angle, "chemicalml/cml/schema24/angle"
      autoload :ArrayList, "chemicalml/cml/schema24/array_list"
      autoload :AtomSet, "chemicalml/cml/schema24/atom_set"
      autoload :AtomType, "chemicalml/cml/schema24/atom_type"
      autoload :AtomTypeList, "chemicalml/cml/schema24/atom_type_list"
      autoload :AtomicBasisFunction, "chemicalml/cml/schema24/atomic_basis_function"
      autoload :Band, "chemicalml/cml/schema24/band"
      autoload :BandList, "chemicalml/cml/schema24/band_list"
      autoload :BasisSet, "chemicalml/cml/schema24/basis_set"
      autoload :BondSet, "chemicalml/cml/schema24/bond_set"
      autoload :BondType, "chemicalml/cml/schema24/bond_type"
      autoload :BondTypeList, "chemicalml/cml/schema24/bond_type_list"
      autoload :CellParameter, "chemicalml/cml/schema24/cell_parameter"
      autoload :ConditionList, "chemicalml/cml/schema24/condition_list"
      autoload :Crystal, "chemicalml/cml/schema24/crystal"
      autoload :Definition, "chemicalml/cml/schema24/definition"
      autoload :Description, "chemicalml/cml/schema24/description"
      autoload :Dimension, "chemicalml/cml/schema24/dimension"
      autoload :Documentation, "chemicalml/cml/schema24/documentation"
      autoload :Eigen, "chemicalml/cml/schema24/eigen"
      autoload :Electron, "chemicalml/cml/schema24/electron"
      autoload :Fragment, "chemicalml/cml/schema24/fragment"
      autoload :FragmentList, "chemicalml/cml/schema24/fragment_list"
      autoload :Gradient, "chemicalml/cml/schema24/gradient"
      autoload :Isotope, "chemicalml/cml/schema24/isotope"
      autoload :IsotopeList, "chemicalml/cml/schema24/isotope_list"
      autoload :Join, "chemicalml/cml/schema24/join"
      autoload :Kpoint, "chemicalml/cml/schema24/kpoint"
      autoload :KpointList, "chemicalml/cml/schema24/kpoint_list"
      autoload :Lattice, "chemicalml/cml/schema24/lattice"
      autoload :LatticeVector, "chemicalml/cml/schema24/lattice_vector"
      autoload :Length, "chemicalml/cml/schema24/length"
      autoload :Line3, "chemicalml/cml/schema24/line3"
      autoload :Link, "chemicalml/cml/schema24/link"
      autoload :Map, "chemicalml/cml/schema24/map"
      autoload :Mechanism, "chemicalml/cml/schema24/mechanism"
      autoload :MechanismComponent, "chemicalml/cml/schema24/mechanism_component"
      autoload :MoleculeList, "chemicalml/cml/schema24/molecule_list"
      autoload :Object, "chemicalml/cml/schema24/object"
      autoload :Observation, "chemicalml/cml/schema24/observation"
      autoload :Particle, "chemicalml/cml/schema24/particle"
      autoload :Peak, "chemicalml/cml/schema24/peak"
      autoload :PeakGroup, "chemicalml/cml/schema24/peak_group"
      autoload :PeakList, "chemicalml/cml/schema24/peak_list"
      autoload :PeakStructure, "chemicalml/cml/schema24/peak_structure"
      autoload :Plane3, "chemicalml/cml/schema24/plane3"
      autoload :Point3, "chemicalml/cml/schema24/point3"
      autoload :Potential, "chemicalml/cml/schema24/potential"
      autoload :PotentialForm, "chemicalml/cml/schema24/potential_form"
      autoload :PotentialList, "chemicalml/cml/schema24/potential_list"
      autoload :ReactionScheme, "chemicalml/cml/schema24/reaction_scheme"
      autoload :ReactionStep, "chemicalml/cml/schema24/reaction_step"
      autoload :ReactionStepList, "chemicalml/cml/schema24/reaction_step_list"
      autoload :ReactiveCentre, "chemicalml/cml/schema24/reactive_centre"
      autoload :Region, "chemicalml/cml/schema24/region"
      autoload :Sample, "chemicalml/cml/schema24/sample"
      autoload :Spectator, "chemicalml/cml/schema24/spectator"
      autoload :SpectatorList, "chemicalml/cml/schema24/spectator_list"
      autoload :Spectrum, "chemicalml/cml/schema24/spectrum"
      autoload :SpectrumData, "chemicalml/cml/schema24/spectrum_data"
      autoload :SpectrumList, "chemicalml/cml/schema24/spectrum_list"
      autoload :Sphere3, "chemicalml/cml/schema24/sphere3"
      autoload :Stmml, "chemicalml/cml/schema24/stmml"
      autoload :SubstanceList, "chemicalml/cml/schema24/substance_list"
      autoload :Symmetry, "chemicalml/cml/schema24/symmetry"
      autoload :System, "chemicalml/cml/schema24/system"
      autoload :Table, "chemicalml/cml/schema24/table"
      autoload :TableCell, "chemicalml/cml/schema24/table_cell"
      autoload :TableContent, "chemicalml/cml/schema24/table_content"
      autoload :TableHeader, "chemicalml/cml/schema24/table_header"
      autoload :TableHeaderCell, "chemicalml/cml/schema24/table_header_cell"
      autoload :TableRow, "chemicalml/cml/schema24/table_row"
      autoload :TableRowList, "chemicalml/cml/schema24/table_row_list"
      autoload :Torsion, "chemicalml/cml/schema24/torsion"
      autoload :Transform3, "chemicalml/cml/schema24/transform3"
      autoload :TransitionState, "chemicalml/cml/schema24/transition_state"
      autoload :Vector3, "chemicalml/cml/schema24/vector3"
      autoload :Xaxis, "chemicalml/cml/schema24/xaxis"
      autoload :Yaxis, "chemicalml/cml/schema24/yaxis"
      autoload :ZMatrix, "chemicalml/cml/schema24/z_matrix"

      SCHEMA = Chemicalml::Schema::Registry.lookup(:schema24)

      autoload :Configuration, "chemicalml/cml/schema24/configuration"
      autoload :Context,       "chemicalml/cml/schema24/context"
      autoload :Array,           "chemicalml/cml/schema24/array"
      autoload :Atom,            "chemicalml/cml/schema24/atom"
      autoload :AtomArray,       "chemicalml/cml/schema24/atom_array"
      autoload :AtomParity,      "chemicalml/cml/schema24/atom_parity"
      autoload :Bond,            "chemicalml/cml/schema24/bond"
      autoload :BondArray,       "chemicalml/cml/schema24/bond_array"
      autoload :BondStereo,      "chemicalml/cml/schema24/bond_stereo"
      autoload :Dictionary,      "chemicalml/cml/schema24/dictionary"
      autoload :DictionaryEntry, "chemicalml/cml/schema24/dictionary_entry"
      autoload :Document,        "chemicalml/cml/schema24/document"
      autoload :Formula,         "chemicalml/cml/schema24/formula"
      autoload :Identifier,      "chemicalml/cml/schema24/identifier"
      autoload :Label,           "chemicalml/cml/schema24/label"
      autoload :List,            "chemicalml/cml/schema24/list"
      autoload :Matrix,          "chemicalml/cml/schema24/matrix"
      autoload :Metadata,        "chemicalml/cml/schema24/metadata"
      autoload :MetadataList,    "chemicalml/cml/schema24/metadata_list"
      autoload :Module,          "chemicalml/cml/schema24/cml_module"
      autoload :Molecule,        "chemicalml/cml/schema24/molecule"
      autoload :Name,            "chemicalml/cml/schema24/name"
      autoload :Parameter,       "chemicalml/cml/schema24/parameter"
      autoload :ParameterList,   "chemicalml/cml/schema24/parameter_list"
      autoload :Product,         "chemicalml/cml/schema24/product"
      autoload :ProductList,     "chemicalml/cml/schema24/product_list"
      autoload :Property,        "chemicalml/cml/schema24/property"
      autoload :PropertyList,    "chemicalml/cml/schema24/property_list"
      autoload :Reaction,        "chemicalml/cml/schema24/reaction"
      autoload :ReactionList,    "chemicalml/cml/schema24/reaction_list"
      autoload :Reactant,        "chemicalml/cml/schema24/reactant"
      autoload :ReactantList,    "chemicalml/cml/schema24/reactant_list"
      autoload :Scalar,          "chemicalml/cml/schema24/scalar"
      autoload :Substance,       "chemicalml/cml/schema24/substance"
      autoload :Unit,            "chemicalml/cml/schema24/unit"
      autoload :UnitList,        "chemicalml/cml/schema24/unit_list"
      autoload :UnitType,        "chemicalml/cml/schema24/unit_type"
      autoload :UnitTypeList,    "chemicalml/cml/schema24/unit_type_list"
      autoload :Alternative, "chemicalml/cml/schema24/alternative"
      autoload :Arg, "chemicalml/cml/schema24/arg"
      autoload :ComplexObject, "chemicalml/cml/schema24/complex_object"
      autoload :Expression, "chemicalml/cml/schema24/expression"
      autoload :Float, "chemicalml/cml/schema24/float"
      autoload :FloatArray, "chemicalml/cml/schema24/float_array"
      autoload :Integer, "chemicalml/cml/schema24/integer"
      autoload :IntegerArray, "chemicalml/cml/schema24/integer_array"
      autoload :Operator, "chemicalml/cml/schema24/operator"
      autoload :RelatedEntry, "chemicalml/cml/schema24/related_entry"
      autoload :String, "chemicalml/cml/schema24/string"
      autoload :StringArray, "chemicalml/cml/schema24/string_array"
      autoload :Tcell, "chemicalml/cml/schema24/tcell"
      autoload :Trow, "chemicalml/cml/schema24/trow"
      autoload :Annotation, "chemicalml/cml/schema24/annotation"
      autoload :Appinfo, "chemicalml/cml/schema24/appinfo"
      autoload :Enumeration, "chemicalml/cml/schema24/enumeration"

      def self.schema
        SCHEMA
      end

      def self.ensure_registered!
        Configuration.ensure_registered!
      end
    end
  end
end
