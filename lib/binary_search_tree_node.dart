

// todo move inot just binary tree code and add tests
// /// {@template searchInOrder}
// /// In in-order traversal, you recursively traverse the left subtree first, then visit the current node, and finally recursively traverse the right subtree.
// /// In-order traversal is commonly used to retrieve the nodes of a binary search tree in ascending order.
// ///           A
// ///         /   \
// ///        B     C
// ///       / \   / \
// ///      D   E F   G
// /// In-order traversal: D, B, E, A, F, C, G
// @mustBeOverridden
// TreeNodeNullable<T>? searchInOrder(bool Function(TreeNodeNullable<T>) test) {
//   return this.inOrderIterable().firstWhereOrNull(test);
// }

// /// {@template inOrderIterable}
// /// In in-order traversal, you recursively traverse the left subtree first, then visit the current node, and finally recursively traverse the right subtree.
// /// In-order traversal is commonly used to retrieve the nodes of a binary search tree in ascending order.
// ///           A
// ///         /   \
// ///        B     C
// ///       / \   / \
// ///      D   E F   G
// /// In-order traversal: D, B, E, A, F, C, G
// /// {@endtemplate}
// @mustBeOverridden
// Iterable<TreeNodeNullable<T>> inOrderIterable() sync* {
//   TreeNodeNullable<T>? firstChild = children_.firstOrNull;
//   if (firstChild != null) {
//     yield* firstChild.inOrderIterable();
//   }
//   yield this;
//   for (final child in children_.skip(1)) {
//     if (child != null) {
//       yield* child.inOrderIterable();
//     }
//   }
// }

/// TODO
// class BinarySearchTreeNode<T extends Comparable<T>> extends LeftRightTreeNode<T> {
//   BinarySearchTreeNode(super.value);
//
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? get parent => super.parent as BinarySearchTreeNode<T>?;
//
//   @override
//   set parent_(covariant BinarySearchTreeNode<T>? node) {
//     super.parent_ = node;
//   }
//
//   @override
//   List<BinarySearchTreeNode<T>?> get children_ {
//     return super.children_.cast<BinarySearchTreeNode<T>?>();
//   }
//
//   @override
//   set children_ (covariant List<BinarySearchTreeNode<T>?> treeNode){
//     super.children_ = treeNode;
//   }
//
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? get left {
//     return children_[0];
//   }
//
//   @override
//   set left(covariant BinarySearchTreeNode<T>? node){
//     children_[0] = node;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? get right {
//     return children_[1];
//   }
//
//   @override
//   set right(covariant BinarySearchTreeNode<T>? node){
//     children_[1] = node;
//   }
//
//   //************************************************************************//
//
//   @override
//   void insert(covariant BinarySearchTreeNode<T> node){
//     BinarySearchTreeNode<T> currentNode = this;
//     while(true) {
//       if(currentNode.value.compareTo(node.value) < 0){
//         if(currentNode.left == null){
//           currentNode.left = node;
//         }
//         else {
//           currentNode = currentNode.left!;
//         }
//       }
//       else {
//         if(currentNode.right == null){
//           currentNode.right = node;
//         }
//         else {
//           currentNode = currentNode.right!;
//         }
//       }
//     }
//   }
//
//   @override
//   void delete(covariant BinarySearchTreeNode<T> node){
//     if(node == this || node.parent == null) {
//       return;
//     }
//     BinarySearchTreeNode<T> parent = node.parent!;
//
//     // Case 1: Node has no children
//     if (node.left == null && node.right == null) {
//       node.removeFromParent();
//       return;
//     }
//     // Case 2: Node has one child
//     if (node.left != null && node.right == null) {
//       _attachChildToGrandParent(node.left!, node, parent);
//       return;
//     }
//     else if(node.right != null && node.left == null){
//       _attachChildToGrandParent(node.right!, node, parent);
//       return;
//     }
//
//     // Case 3: Node has two children
//     // Find the in-order successor (smallest node in the right subtree)
//     BinarySearchTreeNode<T> successor = node.right!;
//     while (successor.left != null) {
//       successor = successor.left!;
//     }
//     node.value = successor.value;
//     delete(successor);
//   }
//
//   void _attachChildToGrandParent(BinarySearchTreeNode<T> child, BinarySearchTreeNode<T> parent, BinarySearchTreeNode<T> grandParent) {
//     final bool isLeft = parent.isLeftInParent();
//     parent.removeFromParent();
//     child.removeFromParent();
//     if(isLeft) {
//       grandParent.left = child;
//     }
//     else {
//       grandParent.right = child;
//     }
//   }
//
//   /// Utilizes the structure of the Binary Search Tree to search for the first
//   /// element that is equal. Faster than regular [search] that is not BST optimized.
//   BinarySearchTreeNode<T>? searchEquals(T element){
//     BinarySearchTreeNode<T>? current = this;
//     do{
//       final int compareVal = element.compareTo(current!.value);
//       if(compareVal == 0){
//         return current;
//       }
//       else if(compareVal < 0){
//         current = left;
//       }
//       else {
//         current = right;
//       }
//     }while(current != null);
//     return null;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? search(covariant bool Function(BinarySearchTreeNode<T>) test) {
//     return super.search((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
//
//   //************************************************************************//
//   // Direct Children Operations
//   //************************************************************************//
//
//   @override
//   List<BinarySearchTreeNode<T>> get children => List<BinarySearchTreeNode<T>>.from(children_);
//
//
//   @override
//   BinarySearchTreeNode<T> operator [](int index) {
//     return super[index] as BinarySearchTreeNode<T>;
//   }
//
//   @override
//   void operator []=(int index, BinarySearchTreeNode<T> value) {
//     super[index] = value;
//   }
//
//   @override
//   int getChildIndex(BinarySearchTreeNode<T> child) {
//     return super.getChildIndex(child);
//   }
//
//   @override
//   bool hasChild(BinarySearchTreeNode<T> child) {
//     return super.hasChild(child);
//   }
//
//   @override
//   BinarySearchTreeNode<T> popChildAtIndex(int index) {
//     return super.popChildAtIndex(index) as BinarySearchTreeNode<T>;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? popChild(BinarySearchTreeNode<T> child) {
//     return super.popChild(child) as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? firstChildOrNull() {
//     return super.firstChildOrNull() as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? lastChildOrNull() {
//     return super.lastChildOrNull() as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? getChildWhere(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.getChildWhere((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>;
//   }
//
//   @override
//   void forEachChild(void Function(BinarySearchTreeNode<T>? node) performAction) {
//     super.forEachChild((e) => performAction(e as BinarySearchTreeNode<T>?));
//   }
//
//   //************************************************************************//
//   // Traversal Methods
//   //************************************************************************//
//
//   // Depth First Traversal
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? searchPreOrder(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.searchPreOrder((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   Iterable<BinarySearchTreeNode<T>> preOrderIterable() sync* {
//     yield* super.preOrderIterable().cast<BinarySearchTreeNode<T>>();
//   }
//
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? searchInOrder(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.searchInOrder((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   Iterable<BinarySearchTreeNode<T>> inOrderIterable() sync* {
//     yield* super. inOrderIterable().cast<BinarySearchTreeNode<T>>();
//   }
//
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? searchPostOrder(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.searchPostOrder((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   Iterable<BinarySearchTreeNode<T>> postOrderIterable() sync* {
//     yield* super.postOrderIterable().cast<BinarySearchTreeNode<T>>();
//   }
//
//   // Breath First Traversal
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? searchLevelOrder(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.searchLevelOrder((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   Iterable<BinarySearchTreeNode<T>> levelOrderIterable() sync* {
//     yield* super.levelOrderIterable().cast<BinarySearchTreeNode<T>>();
//   }
//
//   // Misc Traversal
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T>? searchReverseOrder(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.searchReverseOrder((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
//
//   @override
//   Iterable<BinarySearchTreeNode<T>> reverseOrderIterable() sync* {
//     yield* super.reverseOrderIterable().cast<BinarySearchTreeNode<T>>();
//   }
//
//   //************************************************************************//
//   // Tree Maintenance Operations
//   //************************************************************************//
//
//   @override
//   BinarySearchTreeNode<T> copy() {
//     return super.copy() as BinarySearchTreeNode<T>;
//   }
//
//   //************************************************************************//
//
//   // Generic covariance not supported
//   // @override
//   // BinarySearchTreeNode<E> map<E extends Comparable<E>>(E Function(T e) toElement) {
//   //   return super.map(toElement) as BinarySearchTreeNode<E>;
//   // }
//
//   /// Maps the comparable object T to a new comparable object E
//   BinarySearchTreeNode<E> mapComparable<E extends Comparable<E>>(E Function(T e) toElement) {
//     return super.map(toElement) as BinarySearchTreeNode<E>;
//   }
//
//   //************************************************************************//
//
//   // Generic covariance not supported
//   // @override
//   // BinarySearchTreeNode<E> cast<E extends Comparable<E>>() {
//   //   return super.cast() as BinarySearchTreeNode<E>;
//   // }
//
//   /// Casts all the comparable objects T in the tree to a new comparable objects E
//   BinarySearchTreeNode<E> castComparable<E extends Comparable<E>>() {
//     return super.cast() as BinarySearchTreeNode<E>;
//   }
//
//   //************************************************************************//
//   // Parent Operations
//   //************************************************************************//
//
//   @override
//   bool hasDescendant(BinarySearchTreeNode<T> node) {
//     return super.hasDescendant(node);
//   }
//
//   @override
//   bool hasAncestor(BinarySearchTreeNode<T> node) {
//     return super.hasAncestor(node);
//   }
//
//   @override
//   bool hasSibling(BinarySearchTreeNode<T> node) {
//     return super.hasSibling(node);
//   }
//
//   @override
//   BinarySearchTreeNode<T> getRoot() {
//     return super.getRoot() as BinarySearchTreeNode<T>;
//   }
//
//   @override
//   BinarySearchTreeNode<T>? getParentWhere(bool Function(BinarySearchTreeNode<T>) test) {
//     return super.getParentWhere((e) => test(e as BinarySearchTreeNode<T>)) as BinarySearchTreeNode<T>?;
//   }
// }