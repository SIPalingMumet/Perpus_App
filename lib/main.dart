import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home:MeinApp(),
  ));
}

class MeinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpustakaan Online",
        style: TextStyle(fontFamily:'Roboto', fontSize: 24, color: Colors.white ),),
     backgroundColor: Colors.blueAccent,
     leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: (){

      },
     ),
     actions: [
      IconButton(icon: Icon(Icons.search),
      onPressed: (){
        showSearch(context: context, delegate: BookSearch());
      },)
     ],
      ),
      body : Center(
        child:Text("Selamat Datang Di Perpustakaan Online Malang"),
      ),
    );
  } 
}