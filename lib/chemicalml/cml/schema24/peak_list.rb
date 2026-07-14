# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class PeakList < Lutaml::Model::Serializable
        include Base::PeakList
        include Visitable
        extend Context
      end
    end
  end
end
