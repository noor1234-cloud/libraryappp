import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/services/books.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryCard(
                    label: "Islamic Books",
                    imagePath: "assets/images/islamic book.jpeg",
                  ),
                  CategoryCard(
                    label: "History Books",
                    imagePath: "assets/images/history books.jpeg",
                  ),
                  CategoryCard(
                    label: "Novels",
                    imagePath: "assets/images/novel books.jpeg",
                  ),
                  CategoryCard(
                    label: "Science Books",
                    imagePath: "assets/images/science books.jpeg",
                  ),
                  CategoryCard(
                    label: "Poetry Books",
                    imagePath: "assets/images/poetry books.jpeg",
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('inventory')
                  .doc('bookCounts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                int myBooks = data['myBooks'] ?? 0;
                int outOfStock = data['outOfStock'] ?? 0;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoCard(title: "My Books", count: myBooks),
                    InfoCard(title: "Out of Stock", count: outOfStock),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String label;
  final String imagePath;

  const CategoryCard({
    required this.label,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final int count;

  const InfoCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}