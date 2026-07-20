# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomSet
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomSet

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :size, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'atomSet'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'size', to: :size
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'size', to: :size
            end
          end
        end
      end
    end
  end
end
