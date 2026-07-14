# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomParity
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomParity
            attribute :atom_refs4, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "atomParity"
              map_attribute "atomRefs4", to: :atom_refs4
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
