# frozen_string_literal: true

module Chemicalml
  module Cml
    # Single source of truth for the set of CML element wire classes
    # each schema version must register. Adding a new CML element =
    # adding one entry to `ALL`. Both `Schema3::Configuration` and
    # `Schema24::Configuration` walk this list.
    module Elements
      # Maps the Ruby class name (Symbol, e.g. `:Atom`) to the XML
      # element id used in the lutaml-model type registry
      # (e.g. `:atom`, `:atomArray`).
      ALL = {
        Array:           :array,
        Atom:            :atom,
        AtomArray:       :atomArray,
        AtomParity:      :atomParity,
        Bond:            :bond,
        BondArray:       :bondArray,
        BondStereo:      :bondStereo,
        Dictionary:      :dictionary,
        DictionaryEntry: :entry,
        Document:        :document,
        Formula:         :formula,
        Identifier:      :identifier,
        Label:           :label,
        List:            :list,
        Matrix:          :matrix,
        Metadata:        :metadata,
        MetadataList:    :metadataList,
        Module:          :module,
        Molecule:        :molecule,
        Name:            :name,
        Parameter:       :parameter,
        ParameterList:   :parameterList,
        Product:         :product,
        ProductList:     :productList,
        Property:        :property,
        PropertyList:    :propertyList,
        Reaction:        :reaction,
        ReactionList:    :reactionList,
        Reactant:        :reactant,
        ReactantList:    :reactantList,
        Scalar:          :scalar,
        Substance:       :substance,
        Unit:            :unit,
        UnitList:        :unitList,
        UnitType:        :unitType,
        UnitTypeList:    :unitTypeList,
      }.freeze

      # Elements that exist in Schema 3 but NOT in Schema 2.4. Used by
      # `Schema24::Configuration` to skip registration of classes that
      # don't exist for that version.
      SCHEMA3_ONLY = %i[Module].freeze
    end
  end
end
