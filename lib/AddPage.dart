import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';// Import the main.dart file to access the Book class

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Tambah Buku",
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
            children: [
              SizedBox(height: 10,),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Masukan Judul Buku",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: "Masukan Nama Pengarang",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: "Masukan Tahun Terbit",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _authorController.text.isNotEmpty &&
                      _yearController.text.isNotEmpty) {
                    final newBook = Book(
                      title: _titleController.text,
                      author: _authorController.text,
                      year: _yearController.text,
                    );
                    Navigator.pop(context, newBook);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Semua field harus diisi!"),
                      ),
                    );
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
