# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Spectator < Lutaml::Model::Serializable
        include Base::Spectator
        include Visitable
        extend Context
      end
    end
  end
end
