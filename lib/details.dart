import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set AppBar background color to transparent
        elevation: 0, // Remove AppBar elevation
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Set back icon color to black
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text(
          'This is the second page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
