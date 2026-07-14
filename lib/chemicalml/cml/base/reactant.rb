# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Reactant
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Reactant
            attribute :substance, :substance

            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactant"
              map_element "substance", to: :substance
            end
          end
        end
      end
    end
  end
end
