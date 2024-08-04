import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

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
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  final updatedBook = await Navigator.pushNamed(
                    context,
                    '/update',
                    arguments: {'book': book},
                  );
                  if (updatedBook != null && updatedBook is Book) {
                    // Update book logic here
                  }
                },
                child: Text("Edit"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Delete book logic here
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
