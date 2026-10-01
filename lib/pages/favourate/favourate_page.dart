import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite', style: TextStyle(color: Colors.white,fontSize: 25)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Favourite Page', style: TextStyle(fontSize: 24)),
      )
    );
  }
}
