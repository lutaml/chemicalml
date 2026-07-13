# frozen_string_literal: true

module Chemicalml
  module Cml
    # Shared attribute + xml-mapping declarations for every CML element.
    #
    # Each module here is mixed into the corresponding `Schema3::*` and
    # `Schema24::*` wire class. Schema-version-specific deviations live
    # in `Base::Schema3Only::*` / `Base::Schema24Only::*` and are
    # included only by the relevant version's classes — keeping the
    # shared declarations open for extension, closed for modification.
    module Base
      autoload :Array,            "chemicalml/cml/base/array"
      autoload :Atom,             "chemicalml/cml/base/atom"
      autoload :AtomArray,        "chemicalml/cml/base/atom_array"
      autoload :AtomParity,       "chemicalml/cml/base/atom_parity"
      autoload :Bond,             "chemicalml/cml/base/bond"
      autoload :BondArray,        "chemicalml/cml/base/bond_array"
      autoload :BondStereo,       "chemicalml/cml/base/bond_stereo"
      autoload :Dictionary,       "chemicalml/cml/base/dictionary"
      autoload :DictionaryEntry,  "chemicalml/cml/base/dictionary_entry"
      autoload :Document,         "chemicalml/cml/base/document"
      autoload :Formula,          "chemicalml/cml/base/formula"
      autoload :Identifier,       "chemicalml/cml/base/identifier"
      autoload :Label,            "chemicalml/cml/base/label"
      autoload :List,             "chemicalml/cml/base/list"
      autoload :Matrix,           "chemicalml/cml/base/matrix"
      autoload :Metadata,         "chemicalml/cml/base/metadata"
      autoload :MetadataList,     "chemicalml/cml/base/metadata_list"
      autoload :Module,           "chemicalml/cml/base/cml_module"
      autoload :Molecule,         "chemicalml/cml/base/molecule"
      autoload :Name,             "chemicalml/cml/base/name"
      autoload :Parameter,        "chemicalml/cml/base/parameter"
      autoload :ParameterList,    "chemicalml/cml/base/parameter_list"
      autoload :Product,          "chemicalml/cml/base/product"
      autoload :ProductList,      "chemicalml/cml/base/product_list"
      autoload :Property,         "chemicalml/cml/base/property"
      autoload :PropertyList,     "chemicalml/cml/base/property_list"
      autoload :Reaction,         "chemicalml/cml/base/reaction"
      autoload :ReactionList,     "chemicalml/cml/base/reaction_list"
      autoload :Reactant,         "chemicalml/cml/base/reactant"
      autoload :ReactantList,     "chemicalml/cml/base/reactant_list"
      autoload :Scalar,           "chemicalml/cml/base/scalar"
      autoload :Substance,        "chemicalml/cml/base/substance"
      autoload :Unit,             "chemicalml/cml/base/unit"
      autoload :UnitList,         "chemicalml/cml/base/unit_list"
      autoload :UnitType,         "chemicalml/cml/base/unit_type"
      autoload :UnitTypeList,     "chemicalml/cml/base/unit_type_list"
    end
  end
end
