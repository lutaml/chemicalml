# 70 — Iterative tree walker

## Why

`Chemicalml::Convention::Constraint#walk_nodes` recurses through the
wire tree. CML documents can be deeply nested (cascading modules,
large reaction cascades, etc.) — recursion risks `SystemStackError`
on real-world files.

The constraint walker is also called from `Coordinator.validate`, so
a stack overflow there aborts validation entirely.

## Work

Replace the recursive walk in `lib/chemicalml/convention/constraint.rb`
with an iterative worklist:

```ruby
def walk_nodes(node, path = [], &block)
  return unless visitable?(node)
  worklist = [[node, path]]
  until worklist.empty?
    current, current_path = worklist.shift
    yield(current, current_path)
    children = current.wire_children.map do |child|
      [child, current_path + [describe(child)]]
    end
    worklist.unshift(*children)
  end
end
```

This preserves the same traversal order (DFS pre-order) without
recursion.

## Acceptance

- A deeply-nested CML document (100+ levels of nested Module) walks
  without stack overflow.
- All existing constraint specs pass unchanged.
