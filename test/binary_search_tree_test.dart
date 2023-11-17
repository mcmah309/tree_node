

// void main() {
//   final baseTreeTests = BaseTreeTest<BinarySearchTreeNode<String>>((s) => BinarySearchTreeNode<String>(s));
//
//   baseTreeTests.runTests();
// }

// todo move into test
// // In-order traversal
// values = [];
// rootA.inOrderIterable().forEach((node) => values.add(node.value));
// expect(values, equals(["D", "B", "E", "A", "F", "C", "G"]));
//
//
// // In-order traversal
// values = [];
// val = rootA.searchInOrder((node) {
// if (node.value == "G") {
// return true;
// }
// values.add(node.value);
// return false;
// });
// expect(values, equals(["D", "B", "E", "A", "F", "C"]));
// expect(val?.value, equals("G"));