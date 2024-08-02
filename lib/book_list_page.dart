import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class BookListPage extends StatelessWidget {
  final List<Book> books;
  final Function(int) onDeleteBook;
  final Function(int) onEditBook;
  final Function(String) onSearch;

  BookListPage({required this.books, required this.onDeleteBook, required this.onEditBook, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(books[index].title),
                  subtitle: Text("Pengarang: ${books[index].author}\nTahun: ${books[index].year}"),
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
          ),
        ),
      ],
    );
  }
}
