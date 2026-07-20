# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module LatticeVector
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::LatticeVector

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :units, :string

            attribute :periodic, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'latticeVector'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'units', to: :units
              map_attribute 'periodic', to: :periodic
            end
            key_value do
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'units', to: :units
              map 'periodic', to: :periodic
            end
          end
        end
      end
    end
  end
end
