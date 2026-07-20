# frozen_string_literal: true

module Chemicalml
  module Cml
    # The default CML XML namespace. CML itself doesn't actually
    # declare a mandatory namespace URI on its root — most published
    # CML files use the bare element names. We declare this for
    # future schema-validation work and so consumers can request
    # namespaced output via the `namespace:` serialisation option.
    class Namespace < Lutaml::Xml::W3c::XmlNamespace
      uri 'http://www.xml-cml.org/schema'
      prefix_default 'cml'
      element_form_default :unqualified
    end
  end
end
