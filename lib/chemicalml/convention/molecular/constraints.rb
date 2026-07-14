# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        autoload :AtomArrayMustContainAtoms,
                 "chemicalml/convention/molecular/constraints/atom_array_must_contain_atoms"
        autoload :AtomIdsUniqueWithinMolecule,
                 "chemicalml/convention/molecular/constraints/atom_ids_unique_within_molecule"
        autoload :BondMustReferenceAtomsInSameMolecule,
                 "chemicalml/convention/molecular/constraints/bond_must_reference_atoms_in_same_molecule"
        autoload :AtomMustHaveId,
                 "chemicalml/convention/molecular/constraints/atom_must_have_id"
        autoload :AtomMustHaveElementType,
                 "chemicalml/convention/molecular/constraints/atom_must_have_element_type"
        autoload :BondMustHaveAtomRefs2,
                 "chemicalml/convention/molecular/constraints/bond_must_have_atom_refs2"
        autoload :BondMustHaveOrder,
                 "chemicalml/convention/molecular/constraints/bond_must_have_order"
        autoload :MoleculeMustHaveId,
                 "chemicalml/convention/molecular/constraints/molecule_must_have_id"
        autoload :AtomCoordinatesMustBePaired,
                 "chemicalml/convention/molecular/constraints/atom_coordinates_must_be_paired"
        autoload :PropertyMustHaveDictRef,
                 "chemicalml/convention/molecular/constraints/property_must_have_dict_ref"
        autoload :ScalarMustHaveDataType,
                 "chemicalml/convention/molecular/constraints/scalar_must_have_data_type"
        autoload :BondOrderShouldNotBeNumeric,
                 "chemicalml/convention/molecular/constraints/bond_order_should_not_be_numeric"
        autoload :AtomIdMustMatchPattern,
                 "chemicalml/convention/molecular/constraints/atom_id_must_match_pattern"
      end
    end
  end
end
