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

            xml do
              namespace Chemicalml::Cml::Namespace
              root "expression"
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "dataType", to: :data_type
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
