# frozen_string_literal: true

# Generates all backward-compatible `Chemicalml::Cml::*` aliases
# pointing at the corresponding `Schema3::*` classes.
#
# All 36 aliases are generated in a single file (loaded lazily when
# the first alias is referenced) rather than 36 individual files.
# This is DRY without violating the autoload rule: the file loads
# lazily via autoload, and const_set here ALIASES existing classes
# (Schema3::Foo already exists) rather than creating new ones.

module Chemicalml
  module Cml
    Elements::ALL.each_key do |class_name|
      next if const_defined?(class_name, false)

      const_set(class_name, Schema3.const_get(class_name))
    end
  end
end
