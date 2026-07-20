# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        autoload :AtomArrayMustContainAtoms,
                 'chemicalml/convention/molecular/constraints/atom_array_must_contain_atoms'
        autoload :AtomIdsUniqueWithinMolecule,
                 'chemicalml/convention/molecular/constraints/atom_ids_unique_within_molecule'
        autoload :BondMustReferenceAtomsInSameMolecule,
                 'chemicalml/convention/molecular/constraints/bond_must_reference_atoms_in_same_molecule'
        autoload :AtomMustHaveId,
                 'chemicalml/convention/molecular/constraints/atom_must_have_id'
        autoload :AtomMustHaveElementType,
                 'chemicalml/convention/molecular/constraints/atom_must_have_element_type'
        autoload :BondMustHaveAtomRefs2,
                 'chemicalml/convention/molecular/constraints/bond_must_have_atom_refs2'
        autoload :BondMustHaveOrder,
                 'chemicalml/convention/molecular/constraints/bond_must_have_order'
        autoload :MoleculeMustHaveId,
                 'chemicalml/convention/molecular/constraints/molecule_must_have_id'
        autoload :AtomCoordinatesMustBePaired,
                 'chemicalml/convention/molecular/constraints/atom_coordinates_must_be_paired'
        autoload :PropertyMustHaveDictRef,
                 'chemicalml/convention/molecular/constraints/property_must_have_dict_ref'
        autoload :ScalarMustHaveDataType,
                 'chemicalml/convention/molecular/constraints/scalar_must_have_data_type'
        autoload :BondOrderShouldNotBeNumeric,
                 'chemicalml/convention/molecular/constraints/bond_order_should_not_be_numeric'
        autoload :AtomIdMustMatchPattern,
                 'chemicalml/convention/molecular/constraints/atom_id_must_match_pattern'
        autoload :MoleculeCountMustNotAppearOnTopLevel,
                 'chemicalml/convention/molecular/constraints/molecule_count_must_not_appear_on_top_level'
        autoload :MoleculeAtomArrayMutuallyExclusiveWithChildren,
                 'chemicalml/convention/molecular/constraints/molecule_atom_array_mutually_exclusive_with_children'
        autoload :MoleculeBondArrayMutuallyExclusiveWithChildren,
                 'chemicalml/convention/molecular/constraints/molecule_bond_array_mutually_exclusive_with_children'
        autoload :BondStereoWedgeHashMustHaveAtomRefs2,
                 'chemicalml/convention/molecular/constraints/bond_stereo_wedge_hash_must_have_atom_refs2'
        autoload :BondStereoCisTransMustHaveAtomRefs4,
                 'chemicalml/convention/molecular/constraints/bond_stereo_cis_trans_must_have_atom_refs4'
        autoload :BondStereoOtherMustHaveDictRef,
                 'chemicalml/convention/molecular/constraints/bond_stereo_other_must_have_dict_ref'
        autoload :BondIdsUniqueWithinMolecule,
                 'chemicalml/convention/molecular/constraints/bond_ids_unique_within_molecule'
        autoload :BondOrderOtherMustHaveDictRef,
                 'chemicalml/convention/molecular/constraints/bond_order_other_must_have_dict_ref'
        autoload :AtomArrayMustBeChildOfMoleculeOrFormula,
                 'chemicalml/convention/molecular/constraints/atom_array_must_be_child_of_molecule_or_formula'
        autoload :BondArrayMustBeChildOfMolecule,
                 'chemicalml/convention/molecular/constraints/bond_array_must_be_child_of_molecule'
        autoload :BondOrderShouldBeInEnum,
                 'chemicalml/convention/molecular/constraints/bond_order_should_be_in_enum'
        autoload :BondStereoShouldBeInEnum,
                 'chemicalml/convention/molecular/constraints/bond_stereo_should_be_in_enum'
        autoload :MoleculeChiralityShouldBeInEnum,
                 'chemicalml/convention/molecular/constraints/molecule_chirality_should_be_in_enum'
        autoload :BondAtomRefs2ShouldBeDistinct,
                 'chemicalml/convention/molecular/constraints/bond_atom_refs2_should_be_distinct'
        autoload :ReferencesShouldResolve,
                 'chemicalml/convention/molecular/constraints/references_should_resolve'
        autoload :BondStereoAtomRefs4ShouldBeDistinct,
                 'chemicalml/convention/molecular/constraints/bond_stereo_atom_refs4_should_be_distinct'
        autoload :AtomParityAtomRefs4ShouldBeDistinct,
                 'chemicalml/convention/molecular/constraints/atom_parity_atom_refs4_should_be_distinct'
        autoload :AtomElementTypeShouldBeInPeriodicTable,
                 'chemicalml/convention/molecular/constraints/atom_element_type_should_be_in_periodic_table'
        autoload :DictRefShouldResolve,
                 'chemicalml/convention/molecular/constraints/dict_ref_should_resolve'
        autoload :MoleculeIdShouldMatchPattern,
                 'chemicalml/convention/molecular/constraints/molecule_id_should_match_pattern'
        autoload :BondIdShouldMatchPattern,
                 'chemicalml/convention/molecular/constraints/bond_id_should_match_pattern'
        autoload :AtomParityShouldIncludeParentAtom,
                 'chemicalml/convention/molecular/constraints/atom_parity_should_include_parent_atom'
        autoload :PropertyScalarDataTypeMatchesDictionary,
                 'chemicalml/convention/molecular/constraints/property_scalar_data_type_matches_dictionary'
      end
    end
  end
end
