# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module TableContent
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::TableContent
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :table_rows, :tableRow, collection: true
            attribute :table_row_lists, :tableRowList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "tableRow", to: :table_rows
              map_element "tableRowList", to: :table_row_lists
              root "tableContent"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
          end
        end
      end
    end
  end
end
