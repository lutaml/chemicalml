# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Particle
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Particle

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :type, :string

            attribute :x3, :string
            attribute :y3, :string
            attribute :z3, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'particle'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'type', to: :type
              map_attribute 'x3', to: :x3
              map_attribute 'y3', to: :y3
              map_attribute 'z3', to: :z3
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'type', to: :type
              map 'x3', to: :x3
              map 'y3', to: :y3
              map 'z3', to: :z3
            end
          end
        end
      end
    end
  end
end
