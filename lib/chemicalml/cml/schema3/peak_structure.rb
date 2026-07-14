# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class PeakStructure < Lutaml::Model::Serializable
        include Base::PeakStructure
        include Visitable
        extend Context
      end
    end
  end
end
