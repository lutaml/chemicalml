# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Isotope < Lutaml::Model::Serializable
        include Base::Isotope
        include Visitable
        extend Context
      end
    end
  end
end
