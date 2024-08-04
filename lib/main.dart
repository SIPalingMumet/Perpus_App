import 'package:flutter/material.dart';
import 'package:perpus_app/AddPage.dart';
import 'package:perpus_app/login_page.dart';
import 'package:perpus_app/update_page.dart';
import 'package:perpus_app/splash.dart';
import 'package:perpus_app/book_list_page.dart';
import 'package:perpus_app/profil_page.dart';
import 'package:perpus_app/display_book.dart';

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
        '/login': (context) => LoginPage(),
        '/update': (context) => UpdatePage(),
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
  List<Book> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _filteredBooks = books;
  }

  void _addBook(Book book) {
    setState(() {
      books.add(book);
      _filteredBooks = books; // Sync filteredBooks with books
    });
  }

  void _deleteBook(Book book) {
    setState(() {
      books.remove(book);
      _filteredBooks = books; // Sync filteredBooks with books
    });
  }

  void _updateBook(Book oldBook, Book updatedBook) {
    setState(() {
      int bookIndex = books.indexOf(oldBook);
      if (bookIndex != -1) {
        books[bookIndex] = updatedBook;
      }
      _filteredBooks = books; // Sync filteredBooks with books
    });
  }

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

  void _filterBooks(bool? isFiction) {
    if (isFiction == null) {
      setState(() {
        _filteredBooks = books;
      });
    } else {
      setState(() {
        _filteredBooks = books.where((book) => book.isFiction == isFiction).toList();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return BookListPage(
          books: _filteredBooks,
          onSearch: _searchBooks,
          onFilter: _filterBooks,
          onBookSelected: (Book selectedBook) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPage(
                  book: selectedBook,
                  onDelete: _deleteBook,
                  onUpdate: _updateBook,
                ),
              ),
            );
          },
        );
      case 1:
        return ProfilePage();
      default:
        return Container();
    }
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

class Book {
  final String title;
  final String author;
  final String year;
  final String description;
  final bool isFiction;

  Book({
    required this.title,
    required this.author,
    required this.year,
    required this.description,
    required this.isFiction,
  });
}
