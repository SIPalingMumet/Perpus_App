import 'package:flutter/material.dart';
import 'package:perpus_app/main.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isFiction = true;

  final _formKey = GlobalKey<FormState>();

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Judul buku tidak boleh kosong';
    } else if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
      return 'Judul buku hanya boleh mengandung huruf dan angka';
    }
  return null;
}

  String? _validateAuthor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama pengarang tidak boleh kosong';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Nama pengarang hanya boleh mengandung huruf';
    }
    return null;
  }

  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tahun terbit tidak boleh kosong';
    } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Tahun terbit harus terdiri dari 4 digit angka';
    }
    return null;
  }

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
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Masukan Judul Buku",
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateTitle,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _authorController,
                  decoration: InputDecoration(
                    labelText: "Masukan Nama Pengarang",
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateAuthor,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(
                    labelText: "Masukan Tahun Terbit",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateYear,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Masukan Deskripsi Buku",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Fiksi'),
                        leading: Radio<bool>(
                          value: true,
                          groupValue: _isFiction,
                          onChanged: (bool? value) {
                            setState(() {
                              _isFiction = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Non-Fiksi'),
                        leading: Radio<bool>(
                          value: false,
                          groupValue: _isFiction,
                          onChanged: (bool? value) {
                            setState(() {
                              _isFiction = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newBook = Book(
                        title: _titleController.text,
                        author: _authorController.text,
                        year: _yearController.text,
                        description: _descriptionController.text,
                        isFiction: _isFiction,
                      );
                      Navigator.pop(context, newBook);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Silakan periksa kembali inputan Anda."),
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
      ),
    );
  }
}
