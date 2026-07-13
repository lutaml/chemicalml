# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # CML `<atom>` element. Models a single chemical atom within an
    # `<atomArray>`.
    #
    # CML spec attributes:
    #   id, elementType, count, formalCharge, hydrogenCount,
    #   isotope, isotopeNumber, spinMultiplicity, x2/y2/z2/xy/z3...
    #
    # This class covers the chemistry-relevant subset. 2D/3D
    # coordinates and spectroscopic attributes can be added later
    # without breaking round-trip (they're optional).
    class Atom < Lutaml::Model::Serializable
      attribute :id, :string
      attribute :element_type, :string
      attribute :count, :string
      attribute :formal_charge, :string
      attribute :hydrogen_count, :string
      attribute :isotope, :string
      attribute :isotope_number, :string
      attribute :spin_multiplicity, :string
      attribute :title, :string

      xml do
        root "atom"
        map_attribute "id", to: :id
        map_attribute "elementType", to: :element_type
        map_attribute "count", to: :count
        map_attribute "formalCharge", to: :formal_charge
        map_attribute "hydrogenCount", to: :hydrogen_count
        map_attribute "isotope", to: :isotope
        map_attribute "isotopeNumber", to: :isotope_number
        map_attribute "spinMultiplicity", to: :spin_multiplicity
        map_attribute "title", to: :title
      end
    end
  end
end
