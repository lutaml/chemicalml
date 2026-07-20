# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Expression
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Expression

            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :data_type, :string
            attribute :content, :string

            attribute :operators, :operator, collection: true
            attribute :parameters, :parameter, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'expression'
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'convention', to: :convention
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'dataType', to: :data_type
              map_content to: :content
              map_element 'operator', to: :operators
              map_element 'parameter', to: :parameters
            end
            key_value do
              map 'operator', to: :operators
              map 'parameter', to: :parameters
              map 'title', to: :title
              map 'id', to: :id
              map 'convention', to: :convention
              map 'dictRef', to: :dict_ref
              map 'dataType', to: :data_type
            end
          end
        end
      end
    end
  end
end
