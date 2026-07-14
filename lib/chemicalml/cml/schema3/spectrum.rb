# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Spectrum < Lutaml::Model::Serializable
        include Base::Spectrum
        include Visitable
        extend Context
      end
    end
  end
end
