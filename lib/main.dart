import 'package:flutter/material.dart';
import 'package:perpus_app/AddPage.dart';
import 'package:perpus_app/login_page.dart';
import 'package:perpus_app/update_page.dart';
import 'package:perpus_app/splash.dart';
import 'package:perpus_app/book_list_page.dart';
import 'package:perpus_app/added_books_page.dart';
import 'package:perpus_app/profil_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Perpus Online',
      initialRoute: '/splash',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddPage(),
        '/display': (context) => DisplayPage(),
        '//': (context) => LoginPage(),
        '///': (context) => UpdatePage(),
        '/splash': (context) => SplashScreen(),
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
  int _selectedIndex = 0;
  List<Book> books = [];
  List<Book> addedBooks = [];

  void _addBook(Book book) {
    setState(() {
      books.add(book);
      addedBooks.add(book);
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
                Book bookToRemove = addedBooks[index];
                addedBooks.removeAt(index);
                books.remove(bookToRemove);
                _filteredBooks = books;  // Sync filteredBooks with books
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
    addedBooks[index] = updatedBook;
    int bookIndex = books.indexWhere((book) => book.title == addedBooks[index].title && book.author == addedBooks[index].author);
    if (bookIndex != -1) {
      books[bookIndex] = updatedBook;
    }
    _filteredBooks = books;  // Sync filteredBooks with books
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
                arguments: {'book': addedBooks[index], 'index': index},
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


  List<Book> _filteredBooks = [];

  void _searchBooks(String query) {
    final filteredBooks = books.where((book) {
      final bookTitleLower = book.title.toLowerCase();
      final bookAuthorLower = book.author.toLowerCase();
      final searchLower = query.toLowerCase();
      return bookTitleLower.contains(searchLower) || bookAuthorLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredBooks = filteredBooks;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return BookListPage(books: _filteredBooks.isEmpty ? books : _filteredBooks, onSearch: _searchBooks);
      case 1:
        return AddedBooksPage(books: addedBooks, onDeleteBook: _deleteBook, onEditBook: _confirmEditBook);
      case 2:
        return ProfilePage();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    _filteredBooks = books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikasi Perpus Online"),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: _buildPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newBook = await Navigator.pushNamed(context, '/add');
          if (newBook != null && newBook is Book) {
            _addBook(newBook);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Added Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
        color: Colors.white,
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
                style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 10,),
              Text(
                "Nama Pengarang: ${book.author}",
                style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 10,),
              Text(
                "Tahun Terbit: ${book.year}",
                style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 10,),
              Text(
                "Deskripsi: ${book.description}",
                style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
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
  final String description;

  Book({
    required this.title,
    required this.author,
    required this.year,
    required this.description,
  });
}
