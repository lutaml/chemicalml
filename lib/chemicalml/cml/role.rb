# frozen_string_literal: true

module Chemicalml
  module Cml
    # Role marker modules — one per CML element. Included by every
    # schema-versioned wire class for that element (`Schema3::Molecule`
    # and `Schema24::Molecule` both `include Role::Molecule`).
    #
    # Constraints and translator rules check `node.is_a?(Role::Molecule)`
    # instead of `is_a?(Schema3::Molecule) || is_a?(Schema24::Molecule)`.
    # Adding Schema5 later requires zero constraint edits — Schema5's
    # classes just include the relevant Role modules.
    #
    # Each Role module is empty — it's a pure type marker, no methods.
    module Role
      autoload :Array,           "chemicalml/cml/role/array"
      autoload :Atom,            "chemicalml/cml/role/atom"
      autoload :AtomArray,       "chemicalml/cml/role/atom_array"
      autoload :AtomParity,      "chemicalml/cml/role/atom_parity"
      autoload :Bond,            "chemicalml/cml/role/bond"
      autoload :BondArray,       "chemicalml/cml/role/bond_array"
      autoload :BondStereo,      "chemicalml/cml/role/bond_stereo"
      autoload :Dictionary,      "chemicalml/cml/role/dictionary"
      autoload :DictionaryEntry, "chemicalml/cml/role/dictionary_entry"
      autoload :Document,        "chemicalml/cml/role/document"
      autoload :Formula,         "chemicalml/cml/role/formula"
      autoload :Identifier,      "chemicalml/cml/role/identifier"
      autoload :Label,           "chemicalml/cml/role/label"
      autoload :List,            "chemicalml/cml/role/list"
      autoload :Matrix,          "chemicalml/cml/role/matrix"
      autoload :Metadata,        "chemicalml/cml/role/metadata"
      autoload :MetadataList,    "chemicalml/cml/role/metadata_list"
      autoload :Molecule,        "chemicalml/cml/role/molecule"
      autoload :Module,          "chemicalml/cml/role/cml_module"
      autoload :Name,            "chemicalml/cml/role/name"
      autoload :Parameter,       "chemicalml/cml/role/parameter"
      autoload :ParameterList,   "chemicalml/cml/role/parameter_list"
      autoload :Product,         "chemicalml/cml/role/product"
      autoload :ProductList,     "chemicalml/cml/role/product_list"
      autoload :Property,        "chemicalml/cml/role/property"
      autoload :PropertyList,    "chemicalml/cml/role/property_list"
      autoload :Reaction,        "chemicalml/cml/role/reaction"
      autoload :ReactionList,    "chemicalml/cml/role/reaction_list"
      autoload :Reactant,        "chemicalml/cml/role/reactant"
      autoload :ReactantList,    "chemicalml/cml/role/reactant_list"
      autoload :Scalar,          "chemicalml/cml/role/scalar"
      autoload :Substance,       "chemicalml/cml/role/substance"
      autoload :Unit,            "chemicalml/cml/role/unit"
      autoload :UnitList,        "chemicalml/cml/role/unit_list"
      autoload :UnitType,        "chemicalml/cml/role/unit_type"
      autoload :UnitTypeList,    "chemicalml/cml/role/unit_type_list"
    end
  end
end
