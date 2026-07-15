# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Kpoint
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Kpoint
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :weight, :string
            attribute :content, :string

            attribute :label, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "kpoint"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "weight", to: :weight
              map_content to: :content
              map_attribute "label", to: :label
            end
          end
        end
      end
    end
  end
end
