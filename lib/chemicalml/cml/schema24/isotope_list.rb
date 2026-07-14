# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class IsotopeList < Lutaml::Model::Serializable
        include Base::IsotopeList
        include Visitable
        extend Context
      end
    end
  end
end
