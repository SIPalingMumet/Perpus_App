import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class BookListPage extends StatelessWidget {
  final List<Book> books;
  final Function(String) onSearch;
  final Function(bool?) onFilter;
  final Function(Book) onBookSelected;

  const BookListPage({
    Key? key,
    required this.books,
    required this.onSearch,
    required this.onFilter,
    required this.onBookSelected,
  }) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => onFilter(true),
                child: Text('Fiksi'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => onFilter(false),
                child: Text('Non-Fiksi'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => onFilter(null),
                child: Text('Semua'),
              ),
            ],
          ),
        ),
        Expanded(
          child: books.isEmpty
              ? Center(child: Text("Buku tidak ada"))
              : ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Card(
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text("Pengarang: ${book.author}\nTahun: ${book.year}"),
                        onTap: () {
                          onBookSelected(book); // Use the callback with the selected book
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
