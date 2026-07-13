# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Atom
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Atom
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
            namespace Chemicalml::Cml::Namespace
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
    end
  end
end
