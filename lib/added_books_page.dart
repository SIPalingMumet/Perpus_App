import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class AddedBooksPage extends StatelessWidget {
  final List<Book> books;

  AddedBooksPage({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(books[index].title),
            subtitle: Text("Pengarang: ${books[index].author}\nTahun: ${books[index].year}\nDeskripsi: ${books[index].description}"),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/display',
                arguments: books[index],
              );
            },
          ),
        );
      },
    );
  }
}
