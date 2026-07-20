# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module DictionaryEntry
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::DictionaryEntry

            attribute :id, :string
            attribute :term, :string
            attribute :data_type, :string
            attribute :unit_type, :string
            attribute :units, :string
            attribute :definition, :string
            attribute :description, :string
            attribute :title, :string
            attribute :convention, :string

            # XSD facet attributes — describe the data type the entry
            # represents. Emitted by upstream CML dictionaries to
            # constrain the value space of the term.
            attribute :columns, :string
            attribute :rows, :string
            attribute :length, :string
            attribute :min_length, :string
            attribute :max_length, :string
            attribute :pattern, :string
            attribute :min_exclusive, :string
            attribute :min_inclusive, :string
            attribute :max_exclusive, :string
            attribute :max_inclusive, :string
            attribute :fraction_digits, :string
            attribute :total_digits, :string
            attribute :white_space, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'entry'
              map_attribute 'id', to: :id
              map_attribute 'term', to: :term
              map_attribute 'dataType', to: :data_type
              map_attribute 'unitType', to: :unit_type
              map_attribute 'units', to: :units
              map_attribute 'title', to: :title
              map_attribute 'convention', to: :convention
              map_attribute 'columns', to: :columns
              map_attribute 'rows', to: :rows
              map_attribute 'length', to: :length
              map_attribute 'minLength', to: :min_length
              map_attribute 'maxLength', to: :max_length
              map_attribute 'pattern', to: :pattern
              map_attribute 'minExclusive', to: :min_exclusive
              map_attribute 'minInclusive', to: :min_inclusive
              map_attribute 'maxExclusive', to: :max_exclusive
              map_attribute 'maxInclusive', to: :max_inclusive
              map_attribute 'fractionDigits', to: :fraction_digits
              map_attribute 'totalDigits', to: :total_digits
              map_attribute 'whiteSpace', to: :white_space
              map_element 'definition', to: :definition
              map_element 'description', to: :description
            end
            key_value do
              map 'definition', to: :definition
              map 'description', to: :description
              map 'id', to: :id
              map 'term', to: :term
              map 'dataType', to: :data_type
              map 'unitType', to: :unit_type
              map 'units', to: :units
              map 'title', to: :title
              map 'convention', to: :convention
              map 'columns', to: :columns
              map 'rows', to: :rows
              map 'length', to: :length
              map 'minLength', to: :min_length
              map 'maxLength', to: :max_length
              map 'pattern', to: :pattern
              map 'minExclusive', to: :min_exclusive
              map 'minInclusive', to: :min_inclusive
              map 'maxExclusive', to: :max_exclusive
              map 'maxInclusive', to: :max_inclusive
              map 'fractionDigits', to: :fraction_digits
              map 'totalDigits', to: :total_digits
              map 'whiteSpace', to: :white_space
            end
          end
        end
      end
    end
  end
end
