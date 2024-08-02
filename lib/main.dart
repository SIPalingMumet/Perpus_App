import 'package:flutter/material.dart';
import 'package:perpus_app/AddPage.dart';
import 'package:perpus_app/login_page.dart';
import 'package:perpus_app/splash.dart';
import 'package:perpus_app/update_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Perpus Online',
      initialRoute: '//',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddPage(),
        '/display': (context) => DisplayPage(),
        '//': (context) => LoginPage(),
        '///': (context) => UpdatePage(),
        '////': (context) => SplashScreen()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];

  void _addBook(Book book) {
    setState(() {
      books.add(book);
    });
  }

  void _deleteBook(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus buku ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  books.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _updateBook(int index, Book updatedBook) {
    setState(() {
      books[index] = updatedBook;
    });
  }

  void _confirmEditBook(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Edit'),
          content: Text('Apakah Anda yakin ingin mengedit buku ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final updatedBook = await Navigator.pushNamed(
                  context,
                  '///',
                  arguments: {'book': books[index], 'index': index},
                );
                if (updatedBook != null && updatedBook is Book) {
                  _updateBook(index, updatedBook);
                }
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikasi Perpus Online"),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false
      ),
      body: ListView.builder(
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
                      _confirmEditBook(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteBook(index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBook = await Navigator.pushNamed(context, '/add');
          if (newBook != null && newBook is Book) {
            _addBook(newBook);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Detail Buku",
          style: TextStyle(fontFamily: "Roboto", color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                "Judul Buku: ${book.title}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text(
                "Nama Pengarang: ${book.author}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text(
                "Tahun Terbit: ${book.year}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String year;

  Book({
    required this.title,
    required this.author,
    required this.year,
  });
}
