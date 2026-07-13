# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<reactant>` element. Wraps a `<substance>` that plays the
    # reactant role on the left side of a reaction arrow.
    class Reactant < Lutaml::Model::Serializable
      attribute :substance, Substance

      xml do
        root "reactant"
        map_element "substance", to: :substance
      end
    end
  end
end
