# frozen_string_literal: true

module Chemicalml
  module Cml
    # Defines which child elements each CML container can hold.
    # Adding a new parent-child relationship = adding one entry
    # here. Used by a script to update the Base mixins.
    #
    # Format: parent_class_name => [[child_xml_name, child_ruby_attr, child_type_symbol], ...]
    module ChildMappings
      MAPPINGS = {
        # Molecule — already has names, identifiers, formulas, properties,
        # labels, atom_array, bond_array, molecules. Add more.
        "Molecule" => [
          ["crystal", "crystal", :crystal],
          ["spectrum", "spectra", :spectrum],
          ["propertyList", "property_lists", :propertyList],
        ],
        # Crystal — holds scalar lattice parameters
        "Crystal" => [
          ["scalar", "scalars", :scalar],
          ["lattice", "lattice", :lattice],
          ["symmetry", "symmetry", :symmetry],
        ],
        # Lattice — holds latticeVector children
        "Lattice" => [
          ["latticeVector", "lattice_vectors", :latticeVector],
        ],
        # Spectrum — holds axes and peaks
        "Spectrum" => [
          ["xaxis", "xaxis", :xaxis],
          ["yaxis", "yaxis", :yaxis],
          ["peakList", "peak_list", :peakList],
          ["conditionList", "condition_list", :conditionList],
        ],
        # PeakList — holds peaks
        "PeakList" => [
          ["peak", "peaks", :peak],
          ["peakGroup", "peak_groups", :peakGroup],
        ],
        # PeakGroup — holds peaks
        "PeakGroup" => [
          ["peak", "peaks", :peak],
        ],
        # Reaction — already has reactantList, productList. Add more.
        "Reaction" => [
          ["spectatorList", "spectator_list", :spectatorList],
          ["conditionList", "condition_list", :conditionList],
          ["metadataList", "metadata_lists", :metadataList],
        ],
        # ReactionScheme
        "ReactionScheme" => [
          ["reactionStepList", "reaction_step_lists", :reactionStepList],
          ["reaction", "reactions", :reaction],
        ],
        # ReactionStepList
        "ReactionStepList" => [
          ["reactionStep", "reaction_steps", :reactionStep],
        ],
        # ReactionStep
        "ReactionStep" => [
          ["reaction", "reaction", :reaction],
          ["reactantList", "reactant_list", :reactantList],
          ["productList", "product_list", :productList],
        ],
        # ConditionList
        "ConditionList" => [
          ["scalar", "scalars", :scalar],
          ["metadata", "metadata", :metadata],
        ],
        # FragmentList
        "FragmentList" => [
          ["fragment", "fragments", :fragment],
        ],
        # Fragment
        "Fragment" => [
          ["molecule", "molecule", :molecule],
          ["atomArray", "atom_array", :atomArray],
          ["bondArray", "bond_array", :bondArray],
        ],
        # IsotopeList
        "IsotopeList" => [
          ["isotope", "isotopes", :isotope],
        ],
        # BandList
        "BandList" => [
          ["band", "bands", :band],
        ],
        # KpointList
        "KpointList" => [
          ["kpoint", "kpoints", :kpoint],
        ],
        # PotentialList
        "PotentialList" => [
          ["potential", "potentials", :potential],
        ],
        # Table
        "Table" => [
          ["tableContent", "table_content", :tableContent],
          ["tableHeader", "table_header", :tableHeader],
        ],
        # TableContent
        "TableContent" => [
          ["tableRow", "table_rows", :tableRow],
          ["tableRowList", "table_row_lists", :tableRowList],
        ],
        # TableHeader
        "TableHeader" => [
          ["tableHeaderCell", "table_header_cells", :tableHeaderCell],
        ],
        # TableRow
        "TableRow" => [
          ["tableCell", "table_cells", :tableCell],
        ],
        # TableRowList
        "TableRowList" => [
          ["tableRow", "table_rows", :tableRow],
        ],
        # SpectatorList
        "SpectatorList" => [
          ["spectator", "spectators", :spectator],
        ],
        # MoleculeList
        "MoleculeList" => [
          ["molecule", "molecules", :molecule],
        ],
        # SubstanceList
        "SubstanceList" => [
          ["substance", "substances", :substance],
        ],
        # ActionList
        "ActionList" => [
          ["action", "actions", :action],
        ],
        # AtomTypeList
        "AtomTypeList" => [
          ["atomType", "atom_types", :atomType],
        ],
        # BondTypeList
        "BondTypeList" => [
          ["bondType", "bond_types", :bondType],
        ],
        # Mechanism
        "Mechanism" => [
          ["mechanismComponent", "mechanism_components", :mechanismComponent],
        ],
        # SpectrumList
        "SpectrumList" => [
          ["spectrum", "spectra", :spectrum],
        ],
        # SpectrumData
        "SpectrumData" => [
          ["xaxis", "xaxis", :xaxis],
          ["yaxis", "yaxis", :yaxis],
        ],
        # BasisSet
        "BasisSet" => [
          ["atomicBasisFunction", "atomic_basis_functions", :atomicBasisFunction],
        ],
        # System
        "System" => [
          ["atomArray", "atom_array", :atomArray],
          ["molecule", "molecules", :molecule],
        ],
      }.freeze
    end
  end
end
