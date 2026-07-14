# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class PotentialList < Lutaml::Model::Serializable
        include Base::PotentialList
        include Visitable
        extend Context
      end
    end
  end
end
