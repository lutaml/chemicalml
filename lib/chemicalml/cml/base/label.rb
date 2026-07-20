# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Label
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Label

            attribute :id, :string
            attribute :value, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :object_class, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'label'
              map_attribute 'id', to: :id
              map_attribute 'value', to: :value
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'objectClass', to: :object_class
            end
            key_value do
              map 'id', to: :id
              map 'value', to: :value
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'objectClass', to: :object_class
            end
          end
        end
      end
    end
  end
end
