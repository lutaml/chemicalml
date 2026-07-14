# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Sample < Lutaml::Model::Serializable
        include Base::Sample
        include Visitable
        extend Context
      end
    end
  end
end
