# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Line3
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Line3

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :content, :string

            attribute :units, :string
            attribute :point3, :string
            attribute :vector3, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'line3'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_content to: :content
              map_attribute 'units', to: :units
              map_attribute 'point3', to: :point3
              map_attribute 'vector3', to: :vector3
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'units', to: :units
              map 'point3', to: :point3
              map 'vector3', to: :vector3
            end
          end
        end
      end
    end
  end
end
