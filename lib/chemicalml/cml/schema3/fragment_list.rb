# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class FragmentList < Lutaml::Model::Serializable
        include Base::FragmentList
        include Visitable
        extend Context
      end
    end
  end
end
