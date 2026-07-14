# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondStereo
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondStereo
            attribute :atom_refs2, :string
            attribute :atom_refs4, :string
            attribute :dict_ref, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "bondStereo"
              map_attribute "atomRefs2", to: :atom_refs2
              map_attribute "atomRefs4", to: :atom_refs4
              map_attribute "dictRef", to: :dict_ref
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
