import 'package:flutter/material.dart';
import 'package:perpus_app/AddPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Perpus Online',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddPage(),
        '/display': (context) => DisplayPage(),
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
    setState(() {
      books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikasi Perpus Online"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(books[index].title),
              subtitle: Text("Pengarang: ${books[index].author}\nTahun: ${books[index].year}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteBook(index);
                },
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
