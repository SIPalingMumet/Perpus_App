
import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class AddedBooksPage extends StatelessWidget {
  final List<Book> books;
  final Function(int) onDeleteBook;
  final Function(int) onEditBook;

  AddedBooksPage({required this.books, required this.onDeleteBook, required this.onEditBook});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(books[index].title),
            subtitle: Text("Pengarang: ${books[index].author}\nTahun: ${books[index].year}\nDeskripsi: ${books[index].description}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    onEditBook(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    onDeleteBook(index);
                  },
                ),
              ],
            ),
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
