# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      # Namespace container for all molecular-convention constraint
      # classes. One class per file, registered from the parent
      # `molecular.rb`.
      module Constraints
        autoload :AtomArrayMustContainAtoms,
                 "chemicalml/convention/molecular/constraints/atom_array_must_contain_atoms"
        autoload :AtomIdsUniqueWithinMolecule,
                 "chemicalml/convention/molecular/constraints/atom_ids_unique_within_molecule"
        autoload :BondMustReferenceAtomsInSameMolecule,
                 "chemicalml/convention/molecular/constraints/bond_must_reference_atoms_in_same_molecule"
      end
    end
  end
end
