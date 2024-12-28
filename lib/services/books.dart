import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/books.dart';

class BooksServices {
  /// Create Book
  Future createBook(BooksModel model) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('BooksCollection').doc();
    await documentReference.set(model.toJson(docId: documentReference.id));
  }

  /// Get All Books
  Stream<List<BooksModel>> getAllBooks() {
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('stock', isGreaterThan: 0)
        .snapshots()
        .map((booksList) => booksList.docs
        .map((book) => BooksModel.fromJson(book.data()..['docId'] = book.id))
        .toList());
  }

  /// Get Out-of-Stock Books
  Stream<List<BooksModel>> getOutOfStockBooks() {
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('stock', isEqualTo: 0)
        .snapshots()
        .map((booksList) => booksList.docs
        .map((book) => BooksModel.fromJson(book.data()..['docId'] = book.id))
        .toList());
  }

  /// Get My Books
  Stream<List<BooksModel>> getMyBooks(String userId) {
    value: BooksServices().getMyBooks(userId);
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((booksList) => booksList.docs
        .map((book) => BooksModel.fromJson(book.data()..['docId'] = book.id)) // Add docId
        .toList());
  }

  /// Update Book
  Future updateBook(BooksModel model) async {
    await FirebaseFirestore.instance
        .collection('BooksCollection')
        .doc(model.docId)
        .update({
      "name": model.name,
      "authorName": model.authorName,
      "stock": model.stock,
    });
  }

  /// Delete Book
  Future deleteBook(String docId) async {
    await FirebaseFirestore.instance
        .collection('BooksCollection')
        .doc(docId)
        .delete();
  }
}
