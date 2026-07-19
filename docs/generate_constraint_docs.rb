# frozen_string_literal: true

require "chemicalml"

# Auto-generated documentation of every registered convention
# constraint. Run via `bundle exec rake docs:constraints` or
# `bundle exec ruby docs/generate_constraint_docs.rb`.
#
# Single source of truth: derived from `Convention::Registry.each_constraint`.
# Do not edit `docs/constraints.md` by hand — regenerate.

output = []
output << "# Registered Convention Constraints"
output << ""
output << "Auto-generated from `Chemicalml::Convention::Registry.each_constraint`."
output << "Last regenerated: #{Time.now.utc.iso8601}."
output << ""
output << "Total constraints: **#{Chemicalml::Convention::Registry.total_constraint_count}**"
output << ""

Chemicalml::Convention::Registry.each do |conv|
  output << "## #{conv.qname}"
  output << ""
  output << "- **Namespace**: `#{conv.namespace_uri}`"
  output << "- **Constraint count**: #{conv.constraint_count}"
  output << ""

  output << "| Constraint | Applies to |"
  output << "|---|---|"
  conv.constraints.each do |klass|
    name = klass.name.split("::").last
    roles = klass.applies_to_roles
    applies = roles.nil? ? "_(document-wide)_" : roles.map { |r| r.name.split("::").last }.join(", ")
    output << "| `#{name}` | #{applies} |"
  end
  output << ""
end

path = File.expand_path("constraints.md", __dir__)
File.write(path, output.join("\n"))
puts "Wrote #{path} (#{Chemicalml::Convention::Registry.total_constraint_count} constraints)"
