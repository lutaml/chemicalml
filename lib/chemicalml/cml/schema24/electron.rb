# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Electron < Lutaml::Model::Serializable
        include Base::Electron
        include Visitable
        extend Context
      end
    end
  end
end
