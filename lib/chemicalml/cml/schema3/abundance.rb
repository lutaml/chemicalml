# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Abundance < Lutaml::Model::Serializable
        include Base::Abundance
        include Visitable
        extend Context
      end
    end
  end
end
