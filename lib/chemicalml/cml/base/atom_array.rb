# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomArray
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomArray
            attribute :atoms, :atom, collection: true

            xml do
            namespace Chemicalml::Cml::Namespace
              root "atomArray"
              map_element "atom", to: :atoms
            end
          end
        end
      end
    end
  end
end
