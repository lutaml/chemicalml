# frozen_string_literal: true

module Chemicalml
  module Cml
    # Canonical Ruby source of truth for every XSD simpleType that
    # restricts by `xsd:pattern`. Generated from
    # `reference-docs/schemas/schema3/schema.xsd`. Constants are
    # frozen Regexp objects — adding a new pattern means changing
    # the XSD, then regenerating this file.
    #
    # Naming: XSD `fooType` → Ruby `FOO_PATTERN`. The `Type` suffix
    # is stripped before uppercasing.
    module Patterns
      ATOM_ID_PATTERN = /[A-Za-z_][A-Za-z0-9_-]*(:[A-Za-z0-9_-]+)?/
      BOND_REF_PATTERN = /[A-Za-z0-9_-]+(:[A-Za-z0-9_-]+)?/
      DELIMITER_PATTERN = %r{[!%\^*@~;#,|/]}
      DICTIONARY_PREFIX_PATTERN = /[A-Za-z][A-Za-z0-9_.-]*/
      # formulaType pattern from the XSD. Allows concise formula
      # notation like "C 2 H 6 O 1".
      FORMULA_PATTERN = /\s*([A-Z][a-z]?\s+(([0-9]+(\.[0-9]*)?)|(\.[0-9]*))?\s*)+(\s+-?[0-9]+)?\s*/
      HEAD_PATTERN = /[A-Za-z][A-Za-z0-9_]*/
      ID_PATTERN = /[A-Za-z][A-Za-z0-9.\-_]*/
      ISOTOPIC_SPIN_PATTERN = /\d{1,}(\d+)?/
      MOLECULE_ID_PATTERN = /[A-Za-z_][A-Za-z0-9_-]*(:[A-Za-z0-9_-]+)?/
      NAMESPACE_REF_PATTERN = /[A-Za-z][A-Za-z0-9_]*:[A-Za-z][A-Za-z0-9_.-]*/
      NAMESPACE_PATTERN = %r{http://[A-Za-z][A-Za-z0-9_.-]*(/[A-Za-z0-9_.-]+)+[/#]?}
      REF_PATTERN = /([A-Za-z_][A-Za-z0-9_.-]*:)?[A-Za-z_][A-Za-z0-9_.-]*/
      REPEAT_PATTERN = /[A-Za-z]+ [A-Za-z0-9_\-+]+ [A-Za-z0-9_\-+]+/
      TAIL_PATTERN = /[A-Za-z][A-Za-z0-9_]*/
      VERSION_PATTERN = /[0-9]+(\.[0-9]+[A-Za-z0-9.\-_]*)*/
    end
  end
end
