# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondType
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondType
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :order, :string
            attribute :ref, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "bondType"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "order", to: :order
              map_attribute "ref", to: :ref
            end
          end
        end
      end
    end
  end
end
