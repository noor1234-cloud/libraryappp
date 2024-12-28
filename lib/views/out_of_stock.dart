import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/models/books.dart';
import 'package:libraryapp/services/books.dart';
import 'package:provider/provider.dart';

class GetOutofStockBooksView extends StatelessWidget {
  const GetOutofStockBooksView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get out of stock Books"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>AdBooksView()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamProvider.value(value: BooksServices().getOutOfStockBooks(),
          initialData: [BooksModel()],
                  builder: (context, child) {
                List<BooksModel> bookList = context.watch<List<BooksModel>>();
                    return ListView.builder(
                  itemCount: bookList.length,
                    itemBuilder: (context,i) {
                     return ListTile(
                   leading: Image.network(bookList[i].imageUrl.toString()),
                     title: Text(bookList[i].totalPages.toString()),
                       subtitle: Text(bookList[i].name.toString()),
                         trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                          children: [
                           CupertinoSwitch(
                          value: bookList[i].,
    onChanged: (val) {
    BooksServices().getOutOfStockBooks(
    bookList[i].docId.toString());
    }),
    IconButton(onPressed: () {
    BooksServices()
        .deleteBook(bookList[i].docId.toString());

    },
    icon: const Icon(
    Icons.delete,
    color: Colors.red,
    )),
    IconButton(onPressed:() {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) =>UpdateBookView(model: bookList[i],
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