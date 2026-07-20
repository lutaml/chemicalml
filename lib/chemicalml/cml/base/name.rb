# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Name
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Name

            attribute :content, :string
            attribute :convention, :string
            attribute :dict_ref, :string

            attribute :id, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'name'
              map_content to: :content
              map_attribute 'convention', to: :convention
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'id', to: :id
            end
            key_value do
              map 'convention', to: :convention
              map 'dictRef', to: :dict_ref
              map 'id', to: :id
            end
          end
        end
      end
    end
  end
end
