# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module TableRowList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::TableRowList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :table_rows, :tableRow, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "tableRow", to: :table_rows
              root "tableRowList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
            key_value do
              map "tableRow", to: :table_rows
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
            end

          end
        end
      end
    end
  end
end