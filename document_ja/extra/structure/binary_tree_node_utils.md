# binary_tree_node_utils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/binary_tree_node_utils

## 公開 API

    const ATCODER_BINARY_TREE_NODE_UTILS_HPP* = 1
    type BinaryTreeNode* = concept x, type T
    type BinaryTree* = concept x, type T
    proc greater_func*[K](a,b:K):bool = a < b
    proc isLeaf*[Node:BinaryTreeNode](self:Node):bool =
    proc leftMost*[Node:BinaryTreeNode](self: Node):Node =
    proc rightMost*[Node:BinaryTreeNode](self: Node): Node =
    proc parentLeft*[Node:BinaryTreeNode](node: Node): Node =
    proc parentRight*[Node:BinaryTreeNode](node: Node): Node =
    proc front*[Tree:BinaryTree](self: Tree): Tree.Node = self.root.leftMost
    proc tail*[Tree:BinaryTree](self: Tree): Tree.Node = self.root.rightMost
    proc begin*[Tree:BinaryTree](self:Tree):Tree.Node = self.root.leftMost
    proc succ*[Node:BinaryTreeNode](node: Node): Node =
    proc pred*[Node:BinaryTreeNode](node: Node): Node =
    proc inc*[Node:BinaryTreeNode](node: var Node) =
    proc dec*[Node:BinaryTreeNode](node: var Node) =
    proc `+=`*[Node:BinaryTreeNode](node: var Node, n:int) =
    proc `-=`*[Node:BinaryTreeNode](node: var Node, n:int) =
    proc index*[Node:BinaryTreeNode](t:Node):int =
    proc distance*[Node:BinaryTreeNode](t1, t2:Node):int =
    proc `*`*[Node:BinaryTreeNode](node:Node):auto = node.key
    iterator items*[Node:BinaryTreeNode](s:Slice[Node]):Node =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
