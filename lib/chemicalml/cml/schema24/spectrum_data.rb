# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class SpectrumData < Lutaml::Model::Serializable
        include Base::SpectrumData
        include Visitable
        extend Context
      end
    end
  end
end
