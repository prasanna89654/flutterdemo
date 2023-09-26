import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/material.dart';

class EsewaApp extends StatefulWidget {
  const EsewaApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EsewaApp> createState() => _EsewaAppState();
}

class _EsewaAppState extends State<EsewaApp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           
            EsewaPayButton(
              title: 'Hello',
              paymentConfig: ESewaConfig.dev(
                su: 'https://stackoverflow.com/questions/75117263/how-to-edit-the-taken-picture-with-flutter',
                amt: 10,
                pdc: 18,
                
                tAmt: 28,
                fu: 'https://stackoverflow.com/questions/75117263/how-to-edit-the-taken-picture-with-flutter',
                pid: '12145',  //order id
              ),
              width: 40,
              onFailure: (result) async {},
              onSuccess: (result) async {
                // setState(() {
                //   // refId = result.refId;
                // });
                print(result.toJson());
              },
            ),

          
        
          ],
        ),
      ), 
    );
  }
}
