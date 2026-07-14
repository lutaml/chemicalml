# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class SpectatorList < Lutaml::Model::Serializable
        include Base::SpectatorList
        include Visitable
        extend Context
      end
    end
  end
end
