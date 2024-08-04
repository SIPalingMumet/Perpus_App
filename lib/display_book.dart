import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class DisplayPage extends StatelessWidget {
  final Book book;
  final Function(Book) onDelete;
  final Function(Book, Book) onUpdate;

  const DisplayPage({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  final confirmUpdate = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Konfirmasi Edit"),
                        content: Text("Apakah Anda yakin ingin mengedit buku ini?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Batal"),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: Text("Ya"),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmUpdate == true) {
                    final updatedBook = await Navigator.pushNamed(
                      context,
                      '/update',
                      arguments: book,
                    );

                    if (updatedBook != null && updatedBook is Book) {
                      onUpdate(book, updatedBook);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Buku berhasil diperbarui!")),
                      );
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Text("Edit"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Konfirmasi Hapus"),
                        content: Text("Apakah Anda yakin ingin menghapus buku ini?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Batal"),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: Text("Ya"),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    onDelete(book);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                child: Text("Delete"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
