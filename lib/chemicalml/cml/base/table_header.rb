# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module TableHeader
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::TableHeader
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :table_header_cells, :tableHeaderCell, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "tableHeaderCell", to: :table_header_cells
              root "tableHeader"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
            key_value do
              map "tableHeaderCell", to: :table_header_cells
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