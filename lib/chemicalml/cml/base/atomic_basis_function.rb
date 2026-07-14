# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomicBasisFunction
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomicBasisFunction
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRef, :string
            attribute :n, :string
            attribute :l, :string
            attribute :m, :string
            attribute :ms, :string
            attribute :type, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "atomicBasisFunction"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRef", to: :atomRef
              map_attribute "n", to: :n
              map_attribute "l", to: :l
              map_attribute "m", to: :m
              map_attribute "ms", to: :ms
              map_attribute "type", to: :type
            end
          end
        end
      end
    end
  end
end
