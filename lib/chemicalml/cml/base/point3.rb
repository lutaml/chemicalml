# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Point3
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Point3

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :content, :string

            attribute :units, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'point3'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_content to: :content
              map_attribute 'units', to: :units
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'units', to: :units
            end
          end
        end
      end
    end
  end
end
