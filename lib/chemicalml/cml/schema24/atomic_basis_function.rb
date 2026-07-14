# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class AtomicBasisFunction < Lutaml::Model::Serializable
        include Base::AtomicBasisFunction
        include Visitable
        extend Context
      end
    end
  end
end
