# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class SubstanceList < Lutaml::Model::Serializable
        include Base::SubstanceList
        include Visitable
        extend Context
      end
    end
  end
end
