import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/services/books.dart';
import 'package:libraryapp/views/dashboard.dart';
import 'package:provider/provider.dart';

import '../models/books.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Get my Books"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardView()));
          },
          child: const Icon(Icons.add),
        ),
        body: StreamProvider.value(
          value: BooksServices()
              .getMyBooks(FirebaseAuth.instance.currentUser!.uid),
          initialData: [BooksModel()],
          builder: (context, child) {
            List<BooksModel> bookList = context.watch<List<BooksModel>>();
            return ListView.builder(
                itemCount: bookList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Image.network(bookList[i].imageUrl.toString()),
                    title: Text(bookList[i].name.toString()),
                    subtitle: Text(bookList[i].docId.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoSwitch(
                            value: bookList[i].!,
                            onChanged: (val) {
                              BooksServices().(
                                  bookList[i].docId.toString());
                            }),
                        IconButton(
                            onPressed: () {
                              BooksServices()
                                  .deleteBook(bookList[i].docId.toString());
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateBooksView(
                                        model: bookList[i],
                                      )));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}