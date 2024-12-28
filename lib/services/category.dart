import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libraryapp/models/books.dart';

class CategoryServices {
  /// Create Book
  Future createBook(BooksModel model) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('BooksCollection').doc();
    await documentReference.set(model.toJson());
  }

  /// Get Books by Category ID
  Stream<List<BooksModel>> getBooksByCategory(String catId) {
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('catID', isEqualTo: catId)
        .snapshots()
        .map((booksList) => booksList.docs
        .map((book) => BooksModel.fromJson(book.data()..['docId'] = book.id)) // Add docId
        .toList());
  }

  /// Get All Books
  Stream<List<BooksModel>> getInStockBooks() {
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('stock', isGreaterThan: 0) // Show only in-stock books
        .snapshots()
        .map((booksList) => booksList.docs
        .map((book) => BooksModel.fromJson(book.data()..['docId'] = book.id)) // Add docId
        .toList());
  }

  /// Get Out-of-Stock Books
  Stream<List<BooksModel>> getOutOfStockBooks() {
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('stock', isEqualTo: 0) // Show only out-of-stock books
        .snapshots()
        .map((booksList) => booksList.docs
        .map((book) => BooksModel.fromJson(book.data()..['docId'] = book.id)) // Add docId
        .toList());
  }

  /// Get My Books
  Stream<List<BooksModel>> getMyBooks(String userId) {
    return FirebaseFirestore.instance
        .collection('BooksCollection')
        .where('userID', isEqualTo: userId)
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
