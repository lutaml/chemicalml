# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module MoleculeList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::MoleculeList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :molecules, :molecule, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "molecule", to: :molecules
              root "moleculeList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
          end
        end
      end
    end
  end
end
