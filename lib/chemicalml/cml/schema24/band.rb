# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Band < Lutaml::Model::Serializable
        include Base::Band
        include Visitable
        extend Context
      end
    end
  end
end
