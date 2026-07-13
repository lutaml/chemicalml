# frozen_string_literal: true

module Chemicalml
  # CML model layer. The wire classes live under `Schema3::` and
  # `Schema24::` namespaces; the top-level `Cml::*` constants are
  # backward-compatible aliases pointing at the Schema3 versions.
  # Shared attribute + xml-mapping declarations live under `Base::*`
  # and are included by both schema-versioned class hierarchies.
  module Cml
    autoload :Array, "chemicalml/cml/array"
    autoload :Atom, "chemicalml/cml/atom"
    autoload :AtomArray, "chemicalml/cml/atom_array"
    autoload :AtomParity, "chemicalml/cml/atom_parity"
    autoload :Base, "chemicalml/cml/base"
    autoload :Bond, "chemicalml/cml/bond"
    autoload :BondArray, "chemicalml/cml/bond_array"
    autoload :BondStereo, "chemicalml/cml/bond_stereo"
    autoload :Dictionary, "chemicalml/cml/dictionary"
    autoload :DictionaryEntry, "chemicalml/cml/dictionary_entry"
    autoload :Document, "chemicalml/cml/document"
    autoload :Elements, "chemicalml/cml/elements"
    autoload :Formula, "chemicalml/cml/formula"
    autoload :Identifier, "chemicalml/cml/identifier"
    autoload :Label, "chemicalml/cml/label"
    autoload :List, "chemicalml/cml/list"
    autoload :Matrix, "chemicalml/cml/matrix"
    autoload :Metadata, "chemicalml/cml/metadata"
    autoload :MetadataList, "chemicalml/cml/metadata_list"
    autoload :Module, "chemicalml/cml/cml_module"
    autoload :Molecule, "chemicalml/cml/molecule"
    autoload :Name, "chemicalml/cml/name"
    autoload :Namespace, "chemicalml/cml/namespace"
    autoload :Parameter, "chemicalml/cml/parameter"
    autoload :ParameterList, "chemicalml/cml/parameter_list"
    autoload :Product, "chemicalml/cml/product"
    autoload :ProductList, "chemicalml/cml/product_list"
    autoload :Property, "chemicalml/cml/property"
    autoload :PropertyList, "chemicalml/cml/property_list"
    autoload :Reaction, "chemicalml/cml/reaction"
    autoload :ReactionList, "chemicalml/cml/reaction_list"
    autoload :Reactant, "chemicalml/cml/reactant"
    autoload :ReactantList, "chemicalml/cml/reactant_list"
    autoload :Role, "chemicalml/cml/role"
    autoload :Scalar, "chemicalml/cml/scalar"
    autoload :Schema3, "chemicalml/cml/schema3"
    autoload :Schema24, "chemicalml/cml/schema24"
    autoload :Substance, "chemicalml/cml/substance"
    autoload :Translator, "chemicalml/cml/translator"
    autoload :Unit, "chemicalml/cml/unit"
    autoload :UnitList, "chemicalml/cml/unit_list"
    autoload :UnitType, "chemicalml/cml/unit_type"
    autoload :UnitTypeList, "chemicalml/cml/unit_type_list"
    autoload :Visitable, "chemicalml/cml/visitable"
  end
end
