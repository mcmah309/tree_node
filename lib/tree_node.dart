import 'dart:collection';

import 'package:tree_node/tree_node_nullable.dart';

/// Node of a Tree where children cannot be null. Note "children" does not mean values.
/// Has the exact same functionality as [TreeNodeNullable], through input and
/// output covariance.
class TreeNode<T> extends TreeNodeNullable<T> {

  TreeNode(super.value);

  @override
  TreeNode<T>? get parent => super.parent as TreeNode<T>?;


  @override
  set parent_(TreeNode<T>? node) {
    super.parent_ = node;
  }

  @override
  List<TreeNode<T>> get children_ {
    return super.children_.cast<TreeNode<T>>();
  }

  @override
  set children_ (List<TreeNode<T>> treeNode){
    super.children_ = treeNode;
  }

  //************************************************************************//
  // Utility Methods
  //************************************************************************//

  @override
  void insert(TreeNode<T> node) {
    super.insert(node);
  }

  @override
  void delete(TreeNode<T> node) {
    super.delete(node);
  }

  @override
  TreeNode<T>? search(bool Function(TreeNode<T>) test) {
    return super.search((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  //************************************************************************//
  // Direct Children Operations
  //************************************************************************//

  @override
  List<TreeNode<T>> get children => List<TreeNode<T>>.from(children_);


  @override
  TreeNode<T> operator [](int index) {
    return super[index] as TreeNode<T>;
  }

  @override
  void operator []=(int index, TreeNode<T> value) {
    super[index] = value;
  }

  @override
  int getChildIndex(TreeNode<T> child) {
    return super.getChildIndex(child);
  }

  @override
  bool hasChild(TreeNode<T> child) {
    return super.hasChild(child);
  }

  @override
  TreeNode<T> popChildAtIndex(int index) {
    return super.popChildAtIndex(index) as TreeNode<T>;
  }

  @override
  TreeNode<T>? popChild(TreeNode<T> child) {
    return super.popChild(child) as TreeNode<T>?;
  }

  @override
  TreeNode<T>? firstChildOrNull() {
    return super.firstChildOrNull() as TreeNode<T>?;
  }

  @override
  TreeNode<T>? lastChildOrNull() {
    return super.lastChildOrNull() as TreeNode<T>?;
  }

  @override
  TreeNode<T>? getChildWhere(bool Function(TreeNode<T>) test) {
    return super.getChildWhere((e) => test(e as TreeNode<T>)) as TreeNode<T>;
  }

  @override
  void forEachChild(void Function(TreeNode<T>? node) performAction) {
    super.forEachChild((e) => performAction(e as TreeNode<T>?));
  }

  //************************************************************************//
  // Traversal Methods
  //************************************************************************//

  // Depth First Traversal
  //************************************************************************//

  @override
  TreeNode<T>? searchPreOrder(bool Function(TreeNode<T>) test) {
    return super.searchPreOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  @override
  Iterable<TreeNode<T>> preOrderIterable() sync* {
    yield* super.preOrderIterable().cast<TreeNode<T>>();
  }

  //************************************************************************//

  @override
  TreeNode<T>? searchInOrder(bool Function(TreeNode<T>) test) {
    return super.searchInOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  @override
  Iterable<TreeNode<T>> inOrderIterable() sync* {
    yield* super. inOrderIterable().cast<TreeNode<T>>();
  }

  //************************************************************************//

  @override
  TreeNode<T>? searchPostOrder(bool Function(TreeNode<T>) test) {
    return super.searchPostOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  @override
  Iterable<TreeNode<T>> postOrderIterable() sync* {
    yield* super.postOrderIterable().cast<TreeNode<T>>();
  }

  // Breath First Traversal
  //************************************************************************//

  @override
  TreeNode<T>? searchLevelOrder(bool Function(TreeNode<T>) test) {
    return super.searchLevelOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  @override
  Iterable<TreeNode<T>> levelOrderIterable() sync* {
    yield* super.levelOrderIterable().cast<TreeNode<T>>();
  }

  // Misc Traversal
  //************************************************************************//

  @override
  TreeNode<T>? searchReverseOrder(bool Function(TreeNode<T>) test) {
    return super.searchReverseOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  @override
  Iterable<TreeNode<T>> reverseOrderIterable() sync* {
    yield* super.reverseOrderIterable().cast<TreeNode<T>>();
  }

  //************************************************************************//
  // Tree Maintenance Operations
  //************************************************************************//

  @override
  TreeNode<T> copy() {
    return super.copy() as TreeNode<T>;
  }

  //************************************************************************//

  @override
  TreeNode<E> map<E>(E Function(T e) toElement) {
    return super.map(toElement) as TreeNode<E>;
  }

  //************************************************************************//

  @override
  TreeNode<E> cast<E>() {
    return super.cast() as TreeNode<E>;
  }

  //************************************************************************//
  // Parent Operations
  //************************************************************************//

  @override
  bool hasDescendant(TreeNode<T> node) {
    return super.hasDescendant(node);
  }

  @override
  bool hasAncestor(TreeNode<T> node) {
    return super.hasAncestor(node);
  }

  @override
  bool hasSibling(TreeNode<T> node) {
    return super.hasSibling(node);
  }

  @override
  TreeNode<T> getRoot() {
    return super.getRoot() as TreeNode<T>;
  }

  @override
  TreeNode<T>? getParentWhere(bool Function(TreeNode<T>) test) {
    return super.getParentWhere((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }
}