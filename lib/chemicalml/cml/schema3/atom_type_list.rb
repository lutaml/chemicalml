# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class AtomTypeList < Lutaml::Model::Serializable
        include Base::AtomTypeList
        include Visitable
        extend Context
      end
    end
  end
end
