# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  # CML model layer. Each class in this namespace maps to a CML XML
  # element and is a `Lutaml::Model::Serializable` subclass.
  module Cml
    autoload :Atom, "chemicalml/cml/atom"
    autoload :AtomArray, "chemicalml/cml/atom_array"
    autoload :Bond, "chemicalml/cml/bond"
    autoload :BondArray, "chemicalml/cml/bond_array"
    autoload :Document, "chemicalml/cml/document"
    autoload :Identifier, "chemicalml/cml/identifier"
    autoload :Molecule, "chemicalml/cml/molecule"
    autoload :Name, "chemicalml/cml/name"
    autoload :Namespace, "chemicalml/cml/namespace"
    autoload :Product, "chemicalml/cml/product"
    autoload :ProductList, "chemicalml/cml/product_list"
    autoload :Reaction, "chemicalml/cml/reaction"
    autoload :ReactionList, "chemicalml/cml/reaction_list"
    autoload :Reactant, "chemicalml/cml/reactant"
    autoload :ReactantList, "chemicalml/cml/reactant_list"
    autoload :Substance, "chemicalml/cml/substance"
    autoload :Translator, "chemicalml/cml/translator"
  end
end
