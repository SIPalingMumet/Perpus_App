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
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _initializeBooks();
    _filteredBooks = books.take(_pageSize).toList();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeBooks() {
    books = [
      Book(title: 'Fiction Book a', author: 'Author A', year: '2021', description: 'Description 1', isFiction: true),
      Book(title: 'Fiction Book aa', author: 'Author Ab', year: '2021', description: 'Description 2', isFiction: true),
      Book(title: 'Fiction Book bb', author: 'Author c', year: '2021', description: 'Description 3', isFiction: true),
      Book(title: 'Fiction Book b', author: 'Author cb', year: '2021', description: 'Description 4', isFiction: true),
      Book(title: 'Fiction Book c', author: 'Author rb', year: '2021', description: 'Description 5', isFiction: true),
      Book(title: 'Fiction Book cc', author: 'Author lfr', year: '2021', description: 'Description 6', isFiction: true),
      Book(title: 'Fiction Book d', author: 'Author indf', year: '2021', description: 'Description 7', isFiction: true),
      Book(title: 'Fiction Book dd', author: 'Author bumi', year: '2021', description: 'Description 8', isFiction: true),
      Book(title: 'Fiction Book s', author: 'Author bbca', year: '2021', description: 'Description 9', isFiction: true),
      Book(title: 'Fiction Book ss', author: 'Author jordan', year: '2021', description: 'Description 10', isFiction: true),
      Book(title: 'Fiction Book h', author: 'Author andrew', year: '2021', description: 'Description 11', isFiction: true),
      Book(title: 'Fiction Book hh', author: 'Author Garfiel', year: '2021', description: 'Description 12', isFiction: true),
      Book(title: 'Non-Fiction Book h', author: 'Author noin', year: '2021', description: 'Description 13', isFiction: false),
      Book(title: 'Non-Fiction Book wcd', author: 'Author xd', year: '2021', description: 'Description 14', isFiction: false),
      Book(title: 'Non-Fiction Book sc', author: 'Author rnd', year: '2021', description: 'Description 15', isFiction: false),
      Book(title: 'Non-Fiction Book ewfadc', author: 'Author sf', year: '2021', description: 'Description 16', isFiction: false),
      Book(title: 'Non-Fiction Book wa', author: 'Author tauno', year: '2021', description: 'Description 17', isFiction: false),
      Book(title: 'Non-Fiction Book fwa', author: 'Author remdo', year: '2021', description: 'Description 18', isFiction: false),
      Book(title: 'Non-Fiction Book fwFE', author: 'Author asuw', year: '2021', description: 'Description 19', isFiction: false),
      Book(title: 'Non-Fiction Book FAWE', author: 'Author elik', year: '2021', description: 'Description 20', isFiction: false),
      Book(title: 'Non-Fiction Book esvd', author: 'Author peron', year: '2021', description: 'Description 21', isFiction: false),
      Book(title: 'Non-Fiction Book gears', author: 'Author nando', year: '2021', description: 'Description 22', isFiction: false),
      Book(title: 'Non-Fiction Book gesr', author: 'Author tenhag', year: '2021', description: 'Description 23', isFiction: false),
      Book(title: 'Non-Fiction Book gaer', author: 'Author guardiola', year: '2021', description: 'Description 24', isFiction: false),
      Book(title: 'Non-Fiction Book gaesd', author: 'Author 5varane', year: '2021', description: 'Description 25', isFiction: false),
    ];
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreBooks();
    }
  }

  Future<void> _loadMoreBooks() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    final startIndex = _currentPage * _pageSize;
    final endIndex = startIndex + _pageSize;
    final newBooks = books.skip(startIndex).take(_pageSize).toList();

    setState(() {
      _filteredBooks.addAll(newBooks);
      _isLoading = false;
      _currentPage++;
    });
  }

  void _addBook(Book book) {
    setState(() {
      books.add(book);
      _filteredBooks = books.take(_currentPage * _pageSize).toList();
    });
  }

  void _deleteBook(Book book) {
    setState(() {
      books.remove(book);
      _filteredBooks = books.take(_currentPage * _pageSize).toList();
    });
  }

  void _updateBook(Book oldBook, Book updatedBook) {
    setState(() {
      int bookIndex = books.indexOf(oldBook);
      if (bookIndex != -1) {
        books[bookIndex] = updatedBook;
      }
      _filteredBooks = books.take(_currentPage * _pageSize).toList();
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
      _filteredBooks = filteredBooks.take(_currentPage * _pageSize).toList();
    });
  }

  void _filterBooks(bool? isFiction) {
    if (isFiction == null) {
      setState(() {
        _filteredBooks = books.take(_currentPage * _pageSize).toList();
      });
    } else {
      setState(() {
        _filteredBooks = books.where((book) => book.isFiction == isFiction).take(_currentPage * _pageSize).toList();
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
          scrollController: _scrollController,
          isLoading: _isLoading,
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

class BookListPage extends StatelessWidget {
  final List<Book> books;
  final Function(String) onSearch;
  final Function(bool?) onFilter;
  final Function(Book) onBookSelected;
  final ScrollController scrollController;
  final bool isLoading;

  BookListPage({
    required this.books,
    required this.onSearch,
    required this.onFilter,
    required this.onBookSelected,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
            onChanged: onSearch,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => onFilter(null),
                child: Text('All'),
              ),
              ElevatedButton(
                onPressed: () => onFilter(true),
                child: Text('Fiction'),
              ),
              ElevatedButton(
                onPressed: () => onFilter(false),
                child: Text('Non-Fiction'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: books.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == books.length) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final book = books[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap: () => onBookSelected(book),
              );
            },
          ),
        ),
      ],
    );
  }
}
