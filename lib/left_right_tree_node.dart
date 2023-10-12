import 'package:tree_node/tree_node_nullable.dart';

/// Base class for left right trees like binary search trees such as "red and black trees"
// abstract class LeftRightTreeNode<T> extends TreeNodeNullable<T> {
//   LeftRightTreeNode(super.value){
//     super.children_ = List.of([null, null], growable: false);
//   }
//
//   @override
//   LeftRightTreeNode<T>? get parent => super.parent as LeftRightTreeNode<T>?;
//
//
//   @override
//   set parent_(covariant LeftRightTreeNode<T>? node) {
//     super.parent_ = node;
//   }
//
//   @override
//   List<LeftRightTreeNode<T>?> get children_ {
//     return super.children_.cast<LeftRightTreeNode<T>>();
//   }
//
//   @override
//   set children_ (covariant List<LeftRightTreeNode<T>?> treeNode){
//     super.children_ = treeNode;
//   }
//
//   //************************************************************************//
//
//   LeftRightTreeNode<T>? get left {
//     return children_[0];
//   }
//
//   set left(covariant LeftRightTreeNode<T>? node){
//     children_[0] = node;
//   }
//
//   LeftRightTreeNode<T>? get right {
//     return children_[1];
//   }
//
//   set right(covariant LeftRightTreeNode<T>? node){
//     children_[1] = node;
//   }
//
//   /// Throws if parent is null
//   bool isLeftInParent(){
//     return parent!.left == this;
//   }
//
//   /// Throws if parent is null
//   bool isRightInParent(){
//     return parent!.left == this;
//   }
//
//   //************************************************************************//
//
//   @override
//   void insert(covariant LeftRightTreeNode<T> node);
//
//   @override
//   void delete(covariant LeftRightTreeNode<T> node);
//
//   @override
//   LeftRightTreeNode<T>? search(covariant bool Function(LeftRightTreeNode<T>) test){
//     return super.search((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
//
//   //************************************************************************//
//   // Direct Children Operations
//   //************************************************************************//
//
//   @override
//   List<LeftRightTreeNode<T>> get children => List<LeftRightTreeNode<T>>.from(children_);
//
//
//   @override
//   LeftRightTreeNode<T> operator [](int index) {
//     return super[index] as LeftRightTreeNode<T>;
//   }
//
//   @override
//   void operator []=(int index, LeftRightTreeNode<T> value) {
//     super[index] = value;
//   }
//
//   @override
//   int getChildIndex(LeftRightTreeNode<T> child) {
//     return super.getChildIndex(child);
//   }
//
//   @override
//   bool hasChild(LeftRightTreeNode<T> child) {
//     return super.hasChild(child);
//   }
//
//   @override
//   LeftRightTreeNode<T> popChildAtIndex(int index) {
//     return super.popChildAtIndex(index) as LeftRightTreeNode<T>;
//   }
//
//   @override
//   LeftRightTreeNode<T>? popChild(LeftRightTreeNode<T> child) {
//     return super.popChild(child) as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   LeftRightTreeNode<T>? firstChildOrNull() {
//     return super.firstChildOrNull() as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   LeftRightTreeNode<T>? lastChildOrNull() {
//     return super.lastChildOrNull() as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   LeftRightTreeNode<T>? getChildWhere(bool Function(LeftRightTreeNode<T>) test) {
//     return super.getChildWhere((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>;
//   }
//
//   @override
//   void forEachChild(void Function(LeftRightTreeNode<T>? node) performAction) {
//     super.forEachChild((e) => performAction(e as LeftRightTreeNode<T>?));
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
//   LeftRightTreeNode<T>? searchPreOrder(bool Function(LeftRightTreeNode<T>) test) {
//     return super.searchPreOrder((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   Iterable<LeftRightTreeNode<T>> preOrderIterable() sync* {
//     yield* super.preOrderIterable().cast<LeftRightTreeNode<T>>();
//   }
//
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<T>? searchInOrder(bool Function(LeftRightTreeNode<T>) test) {
//     return super.searchInOrder((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   Iterable<LeftRightTreeNode<T>> inOrderIterable() sync* {
//     yield* super. inOrderIterable().cast<LeftRightTreeNode<T>>();
//   }
//
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<T>? searchPostOrder(bool Function(LeftRightTreeNode<T>) test) {
//     return super.searchPostOrder((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   Iterable<LeftRightTreeNode<T>> postOrderIterable() sync* {
//     yield* super.postOrderIterable().cast<LeftRightTreeNode<T>>();
//   }
//
//   // Breath First Traversal
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<T>? searchLevelOrder(bool Function(LeftRightTreeNode<T>) test) {
//     return super.searchLevelOrder((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   Iterable<LeftRightTreeNode<T>> levelOrderIterable() sync* {
//     yield* super.levelOrderIterable().cast<LeftRightTreeNode<T>>();
//   }
//
//   // Misc Traversal
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<T>? searchReverseOrder(bool Function(LeftRightTreeNode<T>) test) {
//     return super.searchReverseOrder((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
//
//   @override
//   Iterable<LeftRightTreeNode<T>> reverseOrderIterable() sync* {
//     yield* super.reverseOrderIterable().cast<LeftRightTreeNode<T>>();
//   }
//
//   //************************************************************************//
//   // Tree Maintenance Operations
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<T> copy() {
//     return super.copy() as LeftRightTreeNode<T>;
//   }
//
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<E> map<E>(E Function(T e) toElement) {
//     return super.map(toElement) as LeftRightTreeNode<E>;
//   }
//
//   //************************************************************************//
//
//   @override
//   LeftRightTreeNode<E> cast<E>() {
//     return super.cast() as LeftRightTreeNode<E>;
//   }
//
//   //************************************************************************//
//   // Parent Operations
//   //************************************************************************//
//
//   @override
//   bool hasDescendant(LeftRightTreeNode<T> node) {
//     return super.hasDescendant(node);
//   }
//
//   @override
//   bool hasAncestor(LeftRightTreeNode<T> node) {
//     return super.hasAncestor(node);
//   }
//
//   @override
//   bool hasSibling(LeftRightTreeNode<T> node) {
//     return super.hasSibling(node);
//   }
//
//   @override
//   LeftRightTreeNode<T> getRoot() {
//     return super.getRoot() as LeftRightTreeNode<T>;
//   }
//
//   @override
//   LeftRightTreeNode<T>? getParentWhere(bool Function(LeftRightTreeNode<T>) test) {
//     return super.getParentWhere((e) => test(e as LeftRightTreeNode<T>)) as LeftRightTreeNode<T>?;
//   }
// }