import 'package:test/test.dart';
import 'package:tree_node/tree_node_nullable.dart';

void main() {
  final testingSuite =
      BaseTreeTest<TreeNodeNullable<String>>((s) => TreeNodeNullable(s));
  testingSuite.runTests();
}

class BaseTreeTest<T extends TreeNodeNullable<String>> {
  BaseTreeTest(this.constructor);

  final T Function(String) constructor;

  runTests() {
    group("Base Tree Tests", () {
      late T rootA, nodeB, nodeC, nodeD, nodeE, nodeF, nodeG;

      setUp(() {
        rootA = constructor('A');
        nodeB = constructor('B');
        nodeC = constructor('C');
        nodeD = constructor('D');
        nodeE = constructor('E');
        nodeF = constructor('F');
        nodeG = constructor('G');

        rootA.insert(nodeB);
        rootA.insert(nodeC);
        nodeB.insert(nodeD);
        nodeB.insert(nodeE);
        nodeC.insert(nodeF);
        nodeC.insert(nodeG);
      });

      test("Tree ForEach", () {
        // Pre-order traversal
        List<String> values = [];
        rootA.preOrderIterable().forEach((node) => values.add(node.value));
        expect(values, equals(["A", "B", "D", "E", "C", "F", "G"]));

        // In-order traversal
        values = [];
        rootA.inOrderIterable().forEach((node) => values.add(node.value));
        expect(values, equals(["D", "B", "E", "A", "F", "C", "G"]));

        // Post-order traversal
        values = [];
        rootA.postOrderIterable().forEach((node) => values.add(node.value));
        expect(values, equals(["D", "E", "B", "F", "G", "C", "A"]));

        // Level-order traversal
        values = [];
        rootA.levelOrderIterable().forEach((node) => values.add(node.value));
        expect(values, equals(["A", "B", "C", "D", "E", "F", "G"]));

        // Reverse traversal
        values = [];
        nodeG.reverseOrderIterable().forEach((node) => values.add(node.value));
        expect(values, equals(["G", "F", "C", "B", "A"]));
      });

      test("Tree Search", () {
        // Pre-order traversal
        List<String> values = [];
        var val = rootA.searchPreOrder((node) {
          if (node.value == "G") {
            return true;
          }
          values.add(node.value);
          return false;
        });
        expect(values, equals(["A", "B", "D", "E", "C", "F"]));
        expect(val?.value, equals("G"));

        // In-order traversal
        values = [];
        val = rootA.searchInOrder((node) {
          if (node.value == "G") {
            return true;
          }
          values.add(node.value);
          return false;
        });
        expect(values, equals(["D", "B", "E", "A", "F", "C"]));
        expect(val?.value, equals("G"));

        // Post-order traversal
        values = [];
        val = rootA.searchPostOrder((node) {
          if (node.value == "A") {
            return true;
          }
          values.add(node.value);
          return false;
        });
        expect(values, equals(["D", "E", "B", "F", "G", "C"]));
        expect(val?.value, equals("A"));

        // Level-order traversal
        values = [];
        val = rootA.searchLevelOrder((node) {
          if (node.value == "G") {
            return true;
          }
          values.add(node.value);
          return false;
        });
        expect(values, equals(["A", "B", "C", "D", "E", "F"]));
        expect(val?.value, equals("G"));

        // Reverse traversal
        values = [];
        val = nodeG.searchReverseOrder((node) {
          if (node.value == "A") {
            return true;
          }
          values.add(node.value);
          return false;
        });
        expect(values, equals(["G", "F", "C", "B"]));
        expect(val?.value, equals("A"));
      });

      test('insert should add to the tree', () {
        T newNode = constructor("newNode");

        nodeB.insert(newNode);

        expect(nodeB.hasDescendant(newNode), true);
        expect(newNode.hasAncestor(nodeB), true);
      });

      test('delete should remove a node from the tree', () {
        nodeB.delete(nodeD);

        expect(nodeB.hasDescendant(nodeD), false);
        expect(nodeD.hasAncestor(nodeB), false);
      });

      test('search should find a node that satisfies the test condition', () {
        final result = rootA.search((node) => node.value == nodeE.value);

        expect(result, nodeE);
      });

      test('getRoot should return the root node of the tree', () {
        final root = nodeF.getRoot();

        expect(root, rootA);
      });

      test('height should return the height of the tree', () {
        final height = rootA.height;

        expect(height, equals(3));
      });

      test('isLeafNode', () {
        bool isLeaf = nodeF.isLeafNode();
        expect(isLeaf, isTrue);
        isLeaf = nodeB.isLeafNode();
        expect(isLeaf, false);
        isLeaf = rootA.isLeafNode();
        expect(isLeaf, false);
      });

      test('operator [] should return the child node at the specified index',
          () {
        final child = rootA[0];

        expect(child, equals(nodeB));
      });

      test('operator []= should assign a child node at the specified index',
          () {
        T newNode = constructor("newNode");
        rootA[0] = newNode;

        expect(rootA[0], equals(newNode));
        expect(newNode.parent, equals(rootA));
      });

      test('getLengthOfChildren should return the number of children', () {
        final length = rootA.getLengthOfChildren();

        expect(length, equals(2));
      });

      test('getChildIndex should return the index of a child node', () {
        final index = rootA.getChildIndex(nodeC);

        expect(index, equals(1));
      });

      test('hasChildren should return true if there are child nodes', () {
        final hasChildren = rootA.hasChildren();

        expect(hasChildren, isTrue);
      });

      test('hasChild should return true if the node has the specified child',
          () {
        final hasChild = rootA.hasChild(nodeB);

        expect(hasChild, isTrue);
      });

      test('popChildAtIndex',
          () {
        final poppedNode = rootA.popChildAtIndex(0);

        expect(poppedNode, equals(nodeB));
        expect(rootA.hasChild(nodeB), isFalse);
        expect(nodeB.parent, isNull);
      });

      test('get child at index',
          () {
        final child = rootA[0];

        expect(child, equals(nodeB));
      });

      test('getRoot should return the root node of the tree', () {
        final root = nodeF.getRoot();

        expect(root, equals(rootA));
      });
    });
  }
}
