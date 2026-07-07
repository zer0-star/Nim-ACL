when not declared ATCODER_EXTRA_STRUCTURE_TREE_BACKENDS_HPP:
  const ATCODER_EXTRA_STRUCTURE_TREE_BACKENDS_HPP* = 1

  # Documentation-only module.
  #
  # Low-level tree backends intentionally are not imported/exported here.
  # Import the concrete backend directly:
  #
  #   import atcoder/extra/structure/red_black_tree
  #   import atcoder/extra/structure/randomized_binary_search_tree_with_parent
  #   import atcoder/extra/structure/splay_tree
  #
  # These backend modules expose many low-level symbols, and importing several
  # of them together can cause ambiguous names.
