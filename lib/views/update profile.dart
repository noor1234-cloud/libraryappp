import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/models/books.dart';
import 'package:libraryapp/services/books.dart';
import 'package:provider/provider.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider.value(value: BooksServices().getMyBooks(FirebaseAuth.instance.currentUser!.uid),
          initialData:[BooksModel()],
          builder: (context, child) {
        List<BooksModel> myBookList = context.watch<List()

          }),
    )
  }

}