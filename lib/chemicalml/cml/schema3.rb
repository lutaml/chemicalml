# frozen_string_literal: true

module Chemicalml
  module Cml
    # Schema 3 wire classes. Each is a `Lutaml::Model::Serializable`
    # subclass that includes the shared declaration mixin from
    # `Chemicalml::Cml::Base::*`, the `Chemicalml::Cml::Visitable`
    # walker interface, and `extend`s `Schema3::Context` for the
    # `lutaml_default_register` class method.
    #
    # Wire classes are defined in individual files loaded lazily via
    # `autoload` — per the project rule, no `const_set` eager
    # generation. Adding a new CML element means adding one entry
    # to `Elements::ALL`, one `Base::*` mixin, one `Role::*` module,
    # and one per-schema class file.
    module Schema3
      extend Chemicalml::VersionedParser

      autoload :Abundance, 'chemicalml/cml/schema3/abundance'
      autoload :Action, 'chemicalml/cml/schema3/action'
      autoload :ActionList, 'chemicalml/cml/schema3/action_list'
      autoload :Amount, 'chemicalml/cml/schema3/amount'
      autoload :Angle, 'chemicalml/cml/schema3/angle'
      autoload :AnyCml, 'chemicalml/cml/schema3/any_cml'
      autoload :ArrayList, 'chemicalml/cml/schema3/array_list'
      autoload :AtomSet, 'chemicalml/cml/schema3/atom_set'
      autoload :AtomType, 'chemicalml/cml/schema3/atom_type'
      autoload :AtomTypeList, 'chemicalml/cml/schema3/atom_type_list'
      autoload :AtomicBasisFunction, 'chemicalml/cml/schema3/atomic_basis_function'
      autoload :Band, 'chemicalml/cml/schema3/band'
      autoload :BandList, 'chemicalml/cml/schema3/band_list'
      autoload :BasisSet, 'chemicalml/cml/schema3/basis_set'
      autoload :BondSet, 'chemicalml/cml/schema3/bond_set'
      autoload :BondType, 'chemicalml/cml/schema3/bond_type'
      autoload :BondTypeList, 'chemicalml/cml/schema3/bond_type_list'
      autoload :CellParameter, 'chemicalml/cml/schema3/cell_parameter'
      autoload :ConditionList, 'chemicalml/cml/schema3/condition_list'
      autoload :Crystal, 'chemicalml/cml/schema3/crystal'
      autoload :Definition, 'chemicalml/cml/schema3/definition'
      autoload :Description, 'chemicalml/cml/schema3/description'
      autoload :Dimension, 'chemicalml/cml/schema3/dimension'
      autoload :Documentation, 'chemicalml/cml/schema3/documentation'
      autoload :Eigen, 'chemicalml/cml/schema3/eigen'
      autoload :Electron, 'chemicalml/cml/schema3/electron'
      autoload :Fragment, 'chemicalml/cml/schema3/fragment'
      autoload :FragmentList, 'chemicalml/cml/schema3/fragment_list'
      autoload :Gradient, 'chemicalml/cml/schema3/gradient'
      autoload :Isotope, 'chemicalml/cml/schema3/isotope'
      autoload :IsotopeList, 'chemicalml/cml/schema3/isotope_list'
      autoload :Join, 'chemicalml/cml/schema3/join'
      autoload :Kpoint, 'chemicalml/cml/schema3/kpoint'
      autoload :KpointList, 'chemicalml/cml/schema3/kpoint_list'
      autoload :Lattice, 'chemicalml/cml/schema3/lattice'
      autoload :LatticeVector, 'chemicalml/cml/schema3/lattice_vector'
      autoload :Length, 'chemicalml/cml/schema3/length'
      autoload :Line3, 'chemicalml/cml/schema3/line3'
      autoload :Link, 'chemicalml/cml/schema3/link'
      autoload :Map, 'chemicalml/cml/schema3/map'
      autoload :Mechanism, 'chemicalml/cml/schema3/mechanism'
      autoload :MechanismComponent, 'chemicalml/cml/schema3/mechanism_component'
      autoload :MoleculeList, 'chemicalml/cml/schema3/molecule_list'
      autoload :Object, 'chemicalml/cml/schema3/object'
      autoload :Observation, 'chemicalml/cml/schema3/observation'
      autoload :Particle, 'chemicalml/cml/schema3/particle'
      autoload :Peak, 'chemicalml/cml/schema3/peak'
      autoload :PeakGroup, 'chemicalml/cml/schema3/peak_group'
      autoload :PeakList, 'chemicalml/cml/schema3/peak_list'
      autoload :PeakStructure, 'chemicalml/cml/schema3/peak_structure'
      autoload :Plane3, 'chemicalml/cml/schema3/plane3'
      autoload :Point3, 'chemicalml/cml/schema3/point3'
      autoload :Potential, 'chemicalml/cml/schema3/potential'
      autoload :PotentialForm, 'chemicalml/cml/schema3/potential_form'
      autoload :PotentialList, 'chemicalml/cml/schema3/potential_list'
      autoload :ReactionScheme, 'chemicalml/cml/schema3/reaction_scheme'
      autoload :ReactionStep, 'chemicalml/cml/schema3/reaction_step'
      autoload :ReactionStepList, 'chemicalml/cml/schema3/reaction_step_list'
      autoload :ReactiveCentre, 'chemicalml/cml/schema3/reactive_centre'
      autoload :Region, 'chemicalml/cml/schema3/region'
      autoload :Sample, 'chemicalml/cml/schema3/sample'
      autoload :Spectator, 'chemicalml/cml/schema3/spectator'
      autoload :SpectatorList, 'chemicalml/cml/schema3/spectator_list'
      autoload :Spectrum, 'chemicalml/cml/schema3/spectrum'
      autoload :SpectrumData, 'chemicalml/cml/schema3/spectrum_data'
      autoload :SpectrumList, 'chemicalml/cml/schema3/spectrum_list'
      autoload :Sphere3, 'chemicalml/cml/schema3/sphere3'
      autoload :Stmml, 'chemicalml/cml/schema3/stmml'
      autoload :SubstanceList, 'chemicalml/cml/schema3/substance_list'
      autoload :Symmetry, 'chemicalml/cml/schema3/symmetry'
      autoload :System, 'chemicalml/cml/schema3/system'
      autoload :Table, 'chemicalml/cml/schema3/table'
      autoload :TableCell, 'chemicalml/cml/schema3/table_cell'
      autoload :TableContent, 'chemicalml/cml/schema3/table_content'
      autoload :TableHeader, 'chemicalml/cml/schema3/table_header'
      autoload :TableHeaderCell, 'chemicalml/cml/schema3/table_header_cell'
      autoload :TableRow, 'chemicalml/cml/schema3/table_row'
      autoload :TableRowList, 'chemicalml/cml/schema3/table_row_list'
      autoload :Torsion, 'chemicalml/cml/schema3/torsion'
      autoload :Transform3, 'chemicalml/cml/schema3/transform3'
      autoload :TransitionState, 'chemicalml/cml/schema3/transition_state'
      autoload :Vector3, 'chemicalml/cml/schema3/vector3'
      autoload :Xaxis, 'chemicalml/cml/schema3/xaxis'
      autoload :Yaxis, 'chemicalml/cml/schema3/yaxis'
      autoload :ZMatrix, 'chemicalml/cml/schema3/z_matrix'

      SCHEMA = Chemicalml::Schema::Registry.lookup(:schema3)

      autoload :Configuration, 'chemicalml/cml/schema3/configuration'
      autoload :Context,       'chemicalml/cml/schema3/context'
      autoload :Array,           'chemicalml/cml/schema3/array'
      autoload :Atom,            'chemicalml/cml/schema3/atom'
      autoload :AtomArray,       'chemicalml/cml/schema3/atom_array'
      autoload :AtomParity,      'chemicalml/cml/schema3/atom_parity'
      autoload :Bond,            'chemicalml/cml/schema3/bond'
      autoload :BondArray,       'chemicalml/cml/schema3/bond_array'
      autoload :BondStereo,      'chemicalml/cml/schema3/bond_stereo'
      autoload :Dictionary,      'chemicalml/cml/schema3/dictionary'
      autoload :DictionaryEntry, 'chemicalml/cml/schema3/dictionary_entry'
      autoload :Document,        'chemicalml/cml/schema3/document'
      autoload :Formula,         'chemicalml/cml/schema3/formula'
      autoload :Identifier,      'chemicalml/cml/schema3/identifier'
      autoload :Label,           'chemicalml/cml/schema3/label'
      autoload :List,            'chemicalml/cml/schema3/list'
      autoload :Matrix,          'chemicalml/cml/schema3/matrix'
      autoload :Metadata,        'chemicalml/cml/schema3/metadata'
      autoload :MetadataList,    'chemicalml/cml/schema3/metadata_list'
      autoload :Module,          'chemicalml/cml/schema3/cml_module'
      autoload :Molecule,        'chemicalml/cml/schema3/molecule'
      autoload :Name,            'chemicalml/cml/schema3/name'
      autoload :Parameter,       'chemicalml/cml/schema3/parameter'
      autoload :ParameterList,   'chemicalml/cml/schema3/parameter_list'
      autoload :Product,         'chemicalml/cml/schema3/product'
      autoload :ProductList,     'chemicalml/cml/schema3/product_list'
      autoload :Property,        'chemicalml/cml/schema3/property'
      autoload :PropertyList,    'chemicalml/cml/schema3/property_list'
      autoload :Reaction,        'chemicalml/cml/schema3/reaction'
      autoload :ReactionList,    'chemicalml/cml/schema3/reaction_list'
      autoload :Reactant,        'chemicalml/cml/schema3/reactant'
      autoload :ReactantList,    'chemicalml/cml/schema3/reactant_list'
      autoload :Scalar,          'chemicalml/cml/schema3/scalar'
      autoload :Substance,       'chemicalml/cml/schema3/substance'
      autoload :Unit,            'chemicalml/cml/schema3/unit'
      autoload :UnitList,        'chemicalml/cml/schema3/unit_list'
      autoload :UnitType,        'chemicalml/cml/schema3/unit_type'
      autoload :UnitTypeList,    'chemicalml/cml/schema3/unit_type_list'

      def self.schema
        SCHEMA
      end

      def self.ensure_registered!
        Configuration.ensure_registered!
      end
    end
  end
end
