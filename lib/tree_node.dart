import 'dart:collection';

import 'package:tree_node/tree_node_nullable.dart';

/// Node of a Tree where children cannot be null. Note "children" does not mean values.
/// Has the exact same functionality as [TreeNodeNullable], through input and output covariance
class TreeNode<T> extends TreeNodeNullable<T> {

  TreeNode(super.value);

  /// {@macro parent}
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

  /// {@macro insert}
  @override
  void insert(TreeNode<T> node) {
    super.insert(node);
  }

  /// {@macro delete}
  @override
  void delete(TreeNode<T> node) {
    super.delete(node);
  }

  /// {@macro search}
  @override
  TreeNode<T>? search(bool Function(TreeNode<T>) test) {
    return super.search((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  //************************************************************************//
  // Direct Children Operations
  //************************************************************************//

  /// {@macro children}
  @override
  List<TreeNode<T>> get children => List<TreeNode<T>>.from(children_);

  /// {@macro operator[]}
  @override
  TreeNode<T> operator [](int index) {
    return super[index] as TreeNode<T>;
  }

  /// {@macro operator[]=}
  @override
  void operator []=(int index, TreeNode<T> value) {
    super[index] = value;
  }

  /// {@macro getChildIndex}
  @override
  int getChildIndex(TreeNode<T> child) {
    return super.getChildIndex(child);
  }

  /// {@macro hasChild}
  @override
  bool hasChild(TreeNode<T> child) {
    return super.hasChild(child);
  }

  /// {@macro popChildAtIndex}
  @override
  TreeNode<T> popChildAtIndex(int index) {
    return super.popChildAtIndex(index) as TreeNode<T>;
  }

  /// {@macro popChild}
  @override
  TreeNode<T>? popChild(TreeNode<T> child) {
    return super.popChild(child) as TreeNode<T>?;
  }

  /// {@macro firstChildOrNull}
  @override
  TreeNode<T>? firstChildOrNull() {
    return super.firstChildOrNull() as TreeNode<T>?;
  }

  /// {@macro lastChildOrNull}
  @override
  TreeNode<T>? lastChildOrNull() {
    return super.lastChildOrNull() as TreeNode<T>?;
  }

  /// {@macro getChildWhere}
  @override
  TreeNode<T>? getChildWhere(bool Function(TreeNode<T>) test) {
    return super.getChildWhere((e) => test(e as TreeNode<T>)) as TreeNode<T>;
  }

  /// {@macro forEachChild}
  @override
  void forEachChild(void Function(TreeNode<T>? node) performAction) {
    super.forEachChild((e) => performAction(e as TreeNode<T>?));
  }

  //************************************************************************//
  // Traversal Methods
  //************************************************************************//

  // Depth First Traversal
  //************************************************************************//

  /// {@macro searchPreOrder}
  @override
  TreeNode<T>? searchPreOrder(bool Function(TreeNode<T>) test) {
    return super.searchPreOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  /// {@macro preOrderIterable}
  @override
  Iterable<TreeNode<T>> preOrderIterable() sync* {
    yield* super.preOrderIterable().cast<TreeNode<T>>();
  }

  //************************************************************************//

  /// {@macro searchInOrder}
  @override
  TreeNode<T>? searchInOrder(bool Function(TreeNode<T>) test) {
    return super.searchInOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  /// {@macro inOrderIterable}
  @override
  Iterable<TreeNode<T>> inOrderIterable() sync* {
    yield* super. inOrderIterable().cast<TreeNode<T>>();
  }

  //************************************************************************//

  /// {@macro searchPostOrder}
  @override
  TreeNode<T>? searchPostOrder(bool Function(TreeNode<T>) test) {
    return super.searchPostOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  /// {@macro postOrderIterable}
  @override
  Iterable<TreeNode<T>> postOrderIterable() sync* {
    yield* super.postOrderIterable().cast<TreeNode<T>>();
  }

  // Breath First Traversal
  //************************************************************************//

  /// {@macro searchLevelOrder}
  @override
  TreeNode<T>? searchLevelOrder(bool Function(TreeNode<T>) test) {
    return super.searchLevelOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  /// {@macro levelOrderIterable}
  @override
  Iterable<TreeNode<T>> levelOrderIterable() sync* {
    yield* super.levelOrderIterable().cast<TreeNode<T>>();
  }

  // Misc Traversal
  //************************************************************************//

  /// {@macro searchReverseOrder}
  @override
  TreeNode<T>? searchReverseOrder(bool Function(TreeNode<T>) test) {
    return super.searchReverseOrder((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }

  /// {@macro reverseOrderIterable}
  @override
  Iterable<TreeNode<T>> reverseOrderIterable() sync* {
    yield* super.reverseOrderIterable().cast<TreeNode<T>>();
  }

  //************************************************************************//
  // Tree Maintenance Operations
  //************************************************************************//

  /// {@macro copy}
  @override
  TreeNode<T> copy() {
    return super.copy() as TreeNode<T>;
  }

  //************************************************************************//

  /// {@macro map}
  @override
  TreeNode<E> map<E>(E Function(T e) toElement) {
    return super.map(toElement) as TreeNode<E>;
  }

  //************************************************************************//

  /// {@macro cast}
  @override
  TreeNode<E> cast<E>() {
    return super.cast<E>() as TreeNode<E>;
  }

  @override
  TreeNode<E> constructor<E>(E value){
    return TreeNode(value);
  }

  //************************************************************************//
  // Parent Operations
  //************************************************************************//

  /// {@macro hasDescendant}
  @override
  bool hasDescendant(TreeNode<T> node) {
    return super.hasDescendant(node);
  }

  /// {@macro hasAncestor}
  @override
  bool hasAncestor(TreeNode<T> node) {
    return super.hasAncestor(node);
  }

  /// {@macro hasSibling}
  @override
  bool hasSibling(TreeNode<T> node) {
    return super.hasSibling(node);
  }

  /// {@macro getRoot}
  @override
  TreeNode<T> getRoot() {
    return super.getRoot() as TreeNode<T>;
  }

  /// {@macro getParentWhere}
  @override
  TreeNode<T>? getParentWhere(bool Function(TreeNode<T>) test) {
    return super.getParentWhere((e) => test(e as TreeNode<T>)) as TreeNode<T>?;
  }
}
