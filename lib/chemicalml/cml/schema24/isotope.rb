# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Isotope < Lutaml::Model::Serializable
        include Base::Isotope
        include Visitable
        extend Context
      end
    end
  end
end
