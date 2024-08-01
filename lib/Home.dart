import 'package:flutter/material.dart';

// Remove unnecessary import (assuming it's not used)
// import 'package:perpus_app/main.dart';

class Homage extends StatelessWidget {
  const Homage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikasi Perpus Online"),
        backgroundColor: Colors.blue,
      ),
      body: Stack( // Use Stack for better positioning
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            height: double.infinity,
          ),
          // Center content within the container (optional)
          Center(
            child: Text(
              "This container fills the entire page!",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(  // Add FAB here
        onPressed: () {
          Navigator.pushNamed(context, '/Pindah');
        },
        child: Icon(Icons.add), 
      ),
    );
  }
}
