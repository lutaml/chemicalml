# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module TableRow
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::TableRow

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :table_cells, :tableCell, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element 'tableCell', to: :table_cells
              root 'tableRow'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
            end
            key_value do
              map 'tableCell', to: :table_cells
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
            end
          end
        end
      end
    end
  end
end
