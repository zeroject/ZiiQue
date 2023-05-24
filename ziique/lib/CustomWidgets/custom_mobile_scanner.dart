import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ziique/FireService/fire_user_service.dart';
import 'package:ziique/models/user.dart' as beat_user;

class CustomMobileScanner extends StatefulWidget{

  const CustomMobileScanner(BuildContext context, {
    super.key, 
    required this.user
    });

    final beat_user.User user;
  @override
  State<CustomMobileScanner> createState() => _CustomMobileScannerState();
}

class _CustomMobileScannerState extends State<CustomMobileScanner> {
  MobileScannerController scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 41, 41),
        title: const Text("Qr Scanner"),
        actions: [
          IconButton(
            onPressed: (){
              scannerController.switchCamera();
            },
            icon: const Icon(Icons.camera_rear_outlined)
          ),
          IconButton(
            onPressed: (){
              scannerController.toggleTorch();
            },
            icon: const Icon(Icons.flash_on_outlined)
          ), 
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
          controller: scannerController,
          onDetect: (barcode){
              List<String> tempList;
              tempList = widget.user.friends;
              tempList.add(barcode.raw.toString());
              UserService().updateFriendList(tempList);
            }
          ),
          MobileScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
        ]
      ),
    );
  }
}

class MobileScannerOverlay extends StatelessWidget {
  const MobileScannerOverlay({Key? key, required this.overlayColour})
      : super(key: key);

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;
    return Stack(children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(
            overlayColour, BlendMode.srcOut),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.red,
                  backgroundBlendMode: BlendMode
                      .dstOut),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: scanArea,
                width: scanArea,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: CustomPaint(
          child: SizedBox(
            width: scanArea + 25,
            height: scanArea + 25,
          ),
        ),
      ),
    ]);
  }
}