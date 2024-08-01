import 'package:flutter/material.dart';
import 'main.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Book book = args['book'];
    _titleController.text = book.title;
    _authorController.text = book.author;
    _yearController.text = book.year;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final int index = args['index'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Update Buku",
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
                    final updatedBook = Book(
                      title: _titleController.text,
                      author: _authorController.text,
                      year: _yearController.text,
                    );
                    Navigator.pop(context, updatedBook);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Semua field harus diisi!"),
                      ),
                    );
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
