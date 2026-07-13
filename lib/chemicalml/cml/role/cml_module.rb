# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <module> element. Included by Schema3::Module.
      # (Schema24::Module does not exist - schema 2.4 lacks the
      # generic <module> element.)
      module Module
      end
    end
  end
end
