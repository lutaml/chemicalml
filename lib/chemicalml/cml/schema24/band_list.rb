# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class BandList < Lutaml::Model::Serializable
        include Base::BandList
        include Visitable
        extend Context
      end
    end
  end
end
