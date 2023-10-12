import 'package:test/test.dart';
import 'package:tree_node/tree_node.dart';
import 'package:tree_node/tree_node_nullable.dart';

import 'tree_node_nullable_test.dart';

void main() {
  final baseTreeTests = BaseTreeTest<TreeNodeNullable<String>>((s) => TreeNode<String>(s));

  baseTreeTests.runTests();

  final baseTreeCastTests = BaseTreeTest<TreeNodeNullable<String>>((s) => TreeNode<String>(s));

  baseTreeCastTests.runTests();
}