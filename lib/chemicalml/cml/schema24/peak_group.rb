# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class PeakGroup < Lutaml::Model::Serializable
        include Base::PeakGroup
        include Visitable
        extend Context
      end
    end
  end
end
