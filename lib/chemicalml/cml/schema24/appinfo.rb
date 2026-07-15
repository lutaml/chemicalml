# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # Schema 2.4 only. `<appinfo>` carries application-specific
      # metadata. Not in Schema 3.
      class Appinfo < Lutaml::Model::Serializable
        include Base::Appinfo
        include Visitable
        extend Context
      end
    end
  end
end
