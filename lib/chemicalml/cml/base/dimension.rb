# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Dimension
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Dimension

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :dataType, :string
            attribute :units, :string

            attribute :dimension_basis, :string
            attribute :name, :string
            attribute :power, :string
            attribute :preserve, :string
            attribute :unit_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'dimension'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'dataType', to: :dataType
              map_attribute 'units', to: :units
              map_attribute 'dimensionBasis', to: :dimension_basis
              map_attribute 'name', to: :name
              map_attribute 'power', to: :power
              map_attribute 'preserve', to: :preserve
              map_attribute 'unitType', to: :unit_type
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'dataType', to: :dataType
              map 'units', to: :units
              map 'dimensionBasis', to: :dimension_basis
              map 'name', to: :name
              map 'power', to: :power
              map 'preserve', to: :preserve
              map 'unitType', to: :unit_type
            end
          end
        end
      end
    end
  end
end
