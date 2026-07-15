# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Yaxis
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Yaxis
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :units, :string
            attribute :multiplier, :string

            attribute :ref, :string
            attribute :multiplier_to_data, :string
            attribute :constant_to_data, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "yaxis"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "units", to: :units
              map_attribute "multiplier", to: :multiplier
              map_attribute "ref", to: :ref
              map_attribute "multiplierToData", to: :multiplier_to_data
              map_attribute "constantToData", to: :constant_to_data
            end
          end
        end
      end
    end
  end
end
