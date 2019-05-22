# Code extracted from article https://dev.to/siman/get-a-ruby-method-block-source-1if6

def inspector(ast:, &block)
  ast.children.each do |child|
    next unless child.instance_of?(RubyVM::AbstractSyntaxTree::Node)
    yield child
    inspector(ast: child, &block)
  end
end

def find_node(ast:, type:, lineno:)
  inspector(ast: ast) do |node|
    return node if node.type == type && node.first_lineno == lineno
  end
  nil
end

def extract_source(node:, source:)
  first_lineno = node.first_lineno - 1
  first_column = node.first_column
  last_lineno = node.last_lineno - 1
  last_column = node.last_column - 1

  if first_lineno == last_lineno
    source[first_lineno][first_column..last_column]
  else
    src = ' ' * first_column + source[first_lineno][first_column..]
    ((first_lineno + 1)...last_lineno).each do |lineno|
      src << source[lineno]
    end
    src << source[last_lineno][0..last_column]
  end
end

module Kernel
  # RUBY_VERSION >= '2.6.0'
  def block_source
    @file_specs ||= {}
    bl = caller_locations.last
    source = @file_specs.dig(bl.path, :source) || File.readlines(bl.path)
    @file_specs[bl.path] ||= { source: source, ast: RubyVM::AbstractSyntaxTree.parse(source.join) }
    node = find_node(
      ast: @file_specs.dig(bl.path, :ast),
      type: :ITER,
      lineno: bl.lineno
    )
    extract_source(node: node.children[1], source: source) if node
  end
end
