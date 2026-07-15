# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module SpectrumList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::SpectrumList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :spectra, :spectrum

            attribute :ref, :string
            attribute :molecule_ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "spectrum", to: :spectra
              root "spectrumList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
              map_attribute "moleculeRef", to: :molecule_ref
            end
          end
        end
      end
    end
  end
end
