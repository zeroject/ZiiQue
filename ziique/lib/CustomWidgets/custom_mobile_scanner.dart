import 'package:flutter/material.dart';

class CustomQrScanner extends StatelessWidget{
  //MobileScannerController scannerController = MobileScannerController();

  CustomQrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr Scanner"),
        actions: [
          IconButton(
            onPressed: (){
              //scannerController.switchCamera();
            },
            icon: const Icon(Icons.camera_rear_outlined)
          ), 
        ],
      ),
      body: Container(),
    );
  }
}