import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// Node of a Tree with nullable children. Note "children" does not mean values.
/// Base Class for all tree nodes.
/// A Tree can only have one parent and every child node has a parent node.
/// Some tree types can have nullable children, ex: [LeftRightTree]. For a
/// non-nullable version see [TreeNode].
///
/// For extending this class, due to dart's lack of higher-kinded-types
/// and no output covariance.
/// subtypes should override all annotated "@mustBeOverridden" methods for each
/// subtypes. See [TreeNode] for an example.
class TreeNodeNullable<T> {
  TreeNodeNullable(this.value): _children = [];

  T value;


  /// Parent of the current node
  TreeNodeNullable<T>? _parent;

  /// Visible to be used in subtypes. See parent operations otherwise.
  @protected
  @mustBeOverridden
  set parent_(covariant TreeNodeNullable<T>? node){
    _parent = node;
  }

  @mustBeOverridden
  TreeNodeNullable<T>? get parent => _parent;

  /// Children of this current node
  List<TreeNodeNullable<T>?> _children;

  /// Visible since subtype trees may need to restrict the child type, such as to be non-nullable.
  /// See [TreeNode] for an example. Should not use otherwise. See child operations
  /// if the intention is do child operations.
  @protected
  @mustBeOverridden
  set children_(covariant List<TreeNodeNullable<T>?> children){
    _children = children;
  }

  /// Exposed for subtypes. See [children] instead otherwise.
  @protected
  @mustBeOverridden
  List<TreeNodeNullable<T>?> get children_ {
    return _children;
  }

  //************************************************************************//
  // Utility Methods
  //************************************************************************//

  /// {@template insert}
  /// Inserts the new child into the correct location in the tree.
  /// If in a subclass, usually should be overriden.
  /// {@endtemplate}
  @mustBeOverridden
  void insert(covariant TreeNodeNullable<T> node) {
    children_.add(node);
    node._assignParent(this);
  }

  /// {@template delete}
  /// Deletes the node from the tree. Make sure the node exists in the tree beforehand.
  /// If in a subclass, usually should be overriden.
  /// {@endtemplate}
  @mustBeOverridden
  void delete(covariant TreeNodeNullable<T> node) {
    node.removeFromParent();
  }

  /// {@template  search}
  /// Searches for the first node in the tree that matches the test.
  /// If in a subclass, usually should be overriden.
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? search(covariant bool Function(TreeNodeNullable<T>) test) {
    return searchPreOrder(test);
  }

  /// {@template height}
  /// returns the height of this tree from the current level, inclusive
  /// {@endtemplate}
  int get height {
    return heightHelper(1, this);
  }

  @protected
  int heightHelper(int currentDepth, covariant TreeNodeNullable<T> node) {
    int maxDepth = currentDepth;
    for (final child in node.children_) {
      if (child != null) {
        int depth = heightHelper(currentDepth + 1, child);
        if (depth > maxDepth) {
          maxDepth = depth;
        }
      }
    }
    return maxDepth;
  }

  //************************************************************************//
  // Direct Children Operations
  //************************************************************************//

  /// {@template children}
  /// gets a copy of the list of children. To modify the children list of this TreeNode, use another operation.
  /// {@endtemplate}
  @mustBeOverridden
  List<TreeNodeNullable<T>?> get children => List<TreeNodeNullable<T>?>.from(children_);

  bool isLeafNode() {
    return children_.isEmpty || children_.every((element) => element == null);
  }

  @mustBeOverridden
  TreeNodeNullable<T>? operator [](int index) {
    return children_[index];
  }

  @mustBeOverridden
  void operator []=(int index, covariant TreeNodeNullable<T> value) {
    children_[index] = value;
    value.parent_ = this;
  }

  int getLengthOfChildren() {
    return children_.length;
  }

  @mustBeOverridden
  int getChildIndex(covariant TreeNodeNullable<T> child) {
    return children_.indexOf(child);
  }

  bool hasChildren() {
    return children_.isNotEmpty;
  }

  @mustBeOverridden
  bool hasChild(covariant TreeNodeNullable<T>? child) {
    return children_.contains(child);
  }

  /// {@template popChildAtIndex}
  /// Throws if index is not in range
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? popChildAtIndex(int index) {
    TreeNodeNullable<T>? child = children_.removeAt(index);
    if (child == null) {
      return null;
    }
    child.parent_ = null;
    return child;
  }

  /// {@template popChild}
  /// Returns this child if it was popped from the children
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? popChild(covariant TreeNodeNullable<T> child) {
    if (children_.remove(child)) {
      child.parent_ = null;
      return child;
    }
    return null;
  }

  void reverseChildren() {
    children_ = children_.reversed.toList();
  }

  void removeAllChildren() {
    for (final child in children_) {
      child?.parent_ = null;
    }
    children_.clear();
  }

  @mustBeOverridden
  TreeNodeNullable<T>? firstChildOrNull() {
    return children_.firstOrNull;
  }

  @mustBeOverridden
  TreeNodeNullable<T>? lastChildOrNull() {
    return children_.lastOrNull;
  }

  @mustBeOverridden
  TreeNodeNullable<T>? getChildWhere(bool Function(TreeNodeNullable<T>?) test) {
    for (final child in children_) {
      if (test(child)) {
        return child;
      }
    }
    return null;
  }

  @mustBeOverridden
  void forEachChild(void Function(TreeNodeNullable<T>? node) performAction) {
    for (final child in children_) {
      performAction(child);
    }
  }

  //************************************************************************//
  // Traversal Methods
  //************************************************************************//

  // Depth First Traversal
  //************************************************************************//

  /// {@template searchPreOrder}
  /// In pre-order traversal, you visit the current node first, then recursively traverse the left subtree, and finally recursively traverse the right subtree.
  /// Pre-order traversal is commonly used to create a copy of the tree or to serialize the tree structure.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Pre-order traversal: A, B, D, E, C, F, G
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? searchPreOrder(bool Function(TreeNodeNullable<T>) test) {
    return this.preOrderIterable().firstWhereOrNull(test);
  }

  /// {@template preOrderIterable}
  /// In pre-order traversal, you visit the current node first, then recursively traverse the left subtree, and finally recursively traverse the right subtree.
  /// Pre-order traversal is commonly used to create a copy of the tree or to serialize the tree structure.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Pre-order traversal: A, B, D, E, C, F, G
  /// {@endtemplate}
  @mustBeOverridden
  Iterable<TreeNodeNullable<T>> preOrderIterable() sync* {
    yield this;
    for (final child in children_) {
      if (child != null) {
        yield* child.preOrderIterable();
      }
    }
  }

  //************************************************************************//

  /// {@template searchInOrder}
  /// In in-order traversal, you recursively traverse the left subtree first, then visit the current node, and finally recursively traverse the right subtree.
  /// In-order traversal is commonly used to retrieve the nodes of a binary search tree in ascending order.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// In-order traversal: D, B, E, A, F, C, G
  @mustBeOverridden
  TreeNodeNullable<T>? searchInOrder(bool Function(TreeNodeNullable<T>) test) {
    return this.inOrderIterable().firstWhereOrNull(test);
  }

  /// {@template inOrderIterable}
  /// In in-order traversal, you recursively traverse the left subtree first, then visit the current node, and finally recursively traverse the right subtree.
  /// In-order traversal is commonly used to retrieve the nodes of a binary search tree in ascending order.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// In-order traversal: D, B, E, A, F, C, G
  /// {@endtemplate}
  @mustBeOverridden
  Iterable<TreeNodeNullable<T>> inOrderIterable() sync* {
    TreeNodeNullable<T>? firstChild = children_.firstOrNull;
    if (firstChild != null) {
      yield* firstChild.inOrderIterable();
    }
    yield this;
    for (final child in children_.skip(1)) {
      if (child != null) {
        yield* child.inOrderIterable();
      }
    }
  }

  //************************************************************************//

  /// {@template searchPostOrder}
  /// In post-order traversal, you recursively traverse the left subtree first, then recursively traverse the right subtree, and finally visit the current node.
  /// Post-order traversal is commonly used to delete the tree or to perform some calculations involving the descendants of a node before visiting the node itself.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Post-order traversal: D, E, B, F, G, C, A
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? searchPostOrder(bool Function(TreeNodeNullable<T>) test) {
    return this.postOrderIterable().firstWhereOrNull(test);
  }

  /// {@template postOrderIterable}
  /// In post-order traversal, you recursively traverse the left subtree first, then recursively traverse the right subtree, and finally visit the current node.
  /// Post-order traversal is commonly used to delete the tree or to perform some calculations involving the descendants of a node before visiting the node itself.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Post-order traversal: D, E, B, F, G, C, A
  /// {@endtemplate}
  @mustBeOverridden
  Iterable<TreeNodeNullable<T>> postOrderIterable() sync* {
    for (final child in children_) {
      if (child != null) {
        yield* child.postOrderIterable();
      }
    }
    yield this;
  }

  // 1.2 Breath First Traversal
  //************************************************************************//

  /// {@template searchLevelOrder}
  /// In level-order traversal, you visit the nodes level by level, from left to right.
  /// Level-order traversal is useful for exploring or searching a tree breadth-first, and it can be helpful in constructing the tree from a list of nodes.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Level-order traversal: A, B, C, D, E, F, G
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? searchLevelOrder(bool Function(TreeNodeNullable<T>) test) {
    return this.levelOrderIterable().firstWhereOrNull(test);
  }

  /// {@template levelOrderIterable}
  /// In level-order traversal, you visit the nodes level by level, from left to right.
  /// Level-order traversal is useful for exploring or searching a tree breadth-first, and it can be helpful in constructing the tree from a list of nodes.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Level-order traversal: A, B, C, D, E, F, G
  /// {@endtemplate}
  @mustBeOverridden
  Iterable<TreeNodeNullable<T>> levelOrderIterable() sync* {
    final queue = Queue<TreeNodeNullable<T>>();
    queue.add(this);

    while (queue.isNotEmpty) {
      final node = queue.removeFirst();
      yield node;
      queue.addAll(node.children_.whereNotNull());
    }
  }

  // Misc Traversal
  //************************************************************************//

  /// {@template searchReverseOrder}
  /// Reverse traversal, you visit this node, then your previous siblings, then your parent, then your parents previous siblings and so on.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Reverse traversal starting at G: G, F, C, B, A
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T>? searchReverseOrder(bool Function(TreeNodeNullable<T>) test) {
    return this.reverseOrderIterable().firstWhereOrNull(test);
  }

  /// {@template reverseOrderIterable}
  /// Reverse traversal, you visit this node, then your previous siblings, then your parent, then your parents previous siblings and so on.
  ///           A
  ///         /   \
  ///        B     C
  ///       / \   / \
  ///      D   E F   G
  /// Reverse traversal starting at G: G, F, C, B, A
  /// {@endtemplate}
  @mustBeOverridden
  Iterable<TreeNodeNullable<T>> reverseOrderIterable() sync* {
    TreeNodeNullable<T> node = this;
    while (true) {
      if (node.parent != null) {
        int indexInParent = node.parent!.getChildIndex(node);
        for (int i = indexInParent; i >= 0; i--) {
          if (node.parent![i] != null) {
            yield node.parent![i]!;
          }
        }
        node = node.parent!;
      } else {
        yield node;
        break;
      }
    }
  }

  //************************************************************************//
  // Tree Maintenance Operations
  //************************************************************************//

  /// {@template copy}
  /// Creates a copy of this node and all it descendants. Note this will not copy any parent nodes.
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<T> copy() {
    TreeNodeNullable<T> node = constructor<T>(this.value);
    _copyHelper(node, this);
    return node;
  }

  void _copyHelper(TreeNodeNullable<T> newParentNode, TreeNodeNullable<T> oldParentNode) {
    for (final child in oldParentNode.children_) {
      if (child != null) {
        TreeNodeNullable<T> newNode = constructor<T>(child.value);
        newNode.parent_ = newParentNode;
        newParentNode.children_.add(newNode);
        _copyHelper(newNode, child);
      } else {
        newParentNode.children_.add(null);
      }
    }
  }

  //************************************************************************//

  /// {@template map}
  /// Create a copy of this tree node and its descendants and apply the toElement operation on each value
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<E> map<E>(E Function(T e) toElement) {
    TreeNodeNullable<E> node = constructor<E>(toElement(this.value));
    _mapHelper<E>(node, this, toElement);
    return node;
  }

  void _mapHelper<E>(TreeNodeNullable<E> newParentNode, TreeNodeNullable<T> oldParentNode, E Function(T e) toElement) {
    for (final child in oldParentNode.children_) {
      if (child != null) {
        TreeNodeNullable<E> newNode = constructor<E>(toElement(child.value));
        newNode.parent_ = newParentNode;
        newParentNode.children_.add(newNode);
        _mapHelper(newNode, child, toElement);
      } else {
        newParentNode.children_.add(null);
      }
    }
  }

  //************************************************************************//

  /// {@template cast}
  /// Will return a node where all descendant values are cast to E. The ancestor nodes will not be cast. Therefore, the new node will have no parent.
  /// {@endtemplate}
  @mustBeOverridden
  TreeNodeNullable<E> cast<E>() {
    TreeNodeNullable<E> node = constructor<E>(this.value as E);
    _castHelper<E>(node, this);
    return node;
  }

  void _castHelper<E>(TreeNodeNullable<E> newParentNode, TreeNodeNullable<T> oldParentNode) {
    for (final child in oldParentNode.children_) {
      if (child != null) {
        TreeNodeNullable<E> newNode = constructor<E>(child.value as E);
        newNode.parent_ = newParentNode;
        newParentNode.children_.add(newNode);
        _castHelper(newNode, child);
      } else {
        newParentNode.children_.add(null);
      }
    }
  }

  /// Every extending class needs to override for the map, copy, and cast methods to work. This creates a node of
  /// the extending type from the past value
  @mustBeOverridden
  TreeNodeNullable<E> constructor<E>(E value){
    return TreeNodeNullable(value);
  }

  //************************************************************************//

  int numberOfNodesInTree() {
    return this.preOrderIterable().length;
  }

  //************************************************************************//
  // Parent Operations
  //************************************************************************//

  @mustBeOverridden
  bool hasDescendant(covariant TreeNodeNullable<T> node) {
    return node.hasAncestor(this);
  }

  @mustBeOverridden
  bool hasAncestor(covariant TreeNodeNullable<T> node) {
    TreeNodeNullable<T>? ancestor = getParentWhere((p0) => p0 == node);
    if (ancestor == null) {
      return false;
    }
    return true;
  }

  bool hasSibling(covariant TreeNodeNullable<T> node) {
    if (parent != null) {
      return parent!.hasChild(node);
    }
    return false;
  }

  void removeFromParent() {
    if (parent != null) {
      parent!.popChild(this);
      parent == null;
    }
  }

  @mustBeOverridden
  TreeNodeNullable<T> getRoot() {
    if (parent == null) {
      return this;
    }
    TreeNodeNullable<T> node = parent!;
    while (true) {
      if (node.parent != null) {
        node = node.parent!;
      } else {
        return node;
      }
    }
  }

  @mustBeOverridden
  TreeNodeNullable<T>? getParentWhere(bool Function(TreeNodeNullable<T>) test) {
    if (parent == null) {
      return null;
    }
    TreeNodeNullable<T> node = parent!;
    while (true) {
      if (test(node)) {
        return node;
      }
      if (node.parent != null) {
        node = node.parent!;
      } else {
        return null;
      }
    }
  }

  /// {@template level}
  /// Returns the level of this node in the current tree, where the root node is level 1
  /// {@endtemplate}
  int get level {
    int num = 1;
    TreeNodeNullable<T> node = this;
    while (true) {
      if (node.parent != null) {
        num++;
        node = node.parent!;
      } else {
        return num;
      }
    }
  }

  /// {@template heightOfTreeThisNodeBelongsTo}
  /// Returns height of the current tree this node belongs to
  /// {@endtemplate}
  int get heightOfTreeThisNodeBelongsTo {
    if (parent == null) {
      return height;
    }
    TreeNodeNullable<T> node = parent!;
    while (true) {
      if (node.parent != null) {
        node = node.parent!;
      } else {
        return node.height;
      }
    }
  }

  void _assignParent(TreeNodeNullable<T> visitor) {
    parent_ = visitor;
  }
}