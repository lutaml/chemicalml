# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class FragmentList < Lutaml::Model::Serializable
        include Base::FragmentList
        include Visitable
        extend Context
      end
    end
  end
end
