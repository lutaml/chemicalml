# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module SpectrumData
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::SpectrumData
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :xaxis, :xaxis
            attribute :yaxis, :yaxis

            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "xaxis", to: :xaxis
              map_element "yaxis", to: :yaxis
              root "spectrumData"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
            end
          end
        end
      end
    end
  end
end
