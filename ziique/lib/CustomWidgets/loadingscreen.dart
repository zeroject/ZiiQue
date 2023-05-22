import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget{
  const LoadingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../assets/images/Ziique_back.png"),
            fit: BoxFit.none
          )
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}