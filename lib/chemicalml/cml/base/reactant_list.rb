# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactantList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactantList
            attribute :reactants, :reactant, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactantList"
              map_element "reactant", to: :reactants
            end
          end
        end
      end
    end
  end
end
