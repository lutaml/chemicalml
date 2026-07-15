# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Table
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Table
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :table_content, :tableContent
            attribute :table_header, :tableHeader

            attribute :rows, :string
            attribute :columns, :string
            attribute :units, :string
            attribute :table_type, :string
            attribute :data_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "tableContent", to: :table_content
              map_element "tableHeader", to: :table_header
              root "table"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "rows", to: :rows
              map_attribute "columns", to: :columns
              map_attribute "units", to: :units
              map_attribute "tableType", to: :table_type
              map_attribute "dataType", to: :data_type
            end
          end
        end
      end
    end
  end
end
