# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class AtomicBasisFunction < Lutaml::Model::Serializable
        include Base::AtomicBasisFunction
        include Visitable
        extend Context
      end
    end
  end
end
