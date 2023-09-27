import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/material.dart';

class EsewaApp extends StatefulWidget {
  const EsewaApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EsewaApp> createState() => _EsewaAppState();
}

class _EsewaAppState extends State<EsewaApp> {
  String refId = '';
  String hasError = '';
  ESewaConfig paymentConfig = ESewaConfig.dev(
    su: 'https://www.marvel.com/hello',
    amt: 10,
    pdc: 10,
    tAmt: 20,
    fu: 'https://www.marvel.com/hello',
    pid: '123445',
  );
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
            /// Example Use case - 1
            // EsewaPayButton(
            //   paymentConfig: ESewaConfig.dev(
            //     su: 'https://www.marvel.com/hello',
            //     amt: 10,
            //     pdc: 10,
            //     tAmt: 20,
            //     fu: 'https://www.marvel.com/hello',
            //     pid: '123445',
            //   ),
            //   width: 40,
            //   onFailure: (result) async {},
            //   onSuccess: (result) async {
            //     // setState(() {
            //     //   // refId = result.refId;
            //     // });
            //     print(result.toJson());
            //   },
            // ),

            ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await Esewa.i
                        .init(context: context, eSewaConfig: paymentConfig);
                    if (result.hasData) {
                      // onSuccess(result.data!);
                    } else {
                      // onFailure(result.error!);
                    }
                  } catch (e) {
                    // onFailure('An Exception Occurred');
                  }
                },
                child: const Text("Nice"))

            /// Example Use case - 1
            // TextButton(
            //   onPressed: () async {
            //     final result = await Esewa.i.init(
            //         context: context,
            //         eSewaConfig: ESewaConfig.dev(
            //           // .live for live
            //           su: 'https://www.marvel.com/hello',
            //           amt: 10,
            //           fu: 'https://www.marvel.com/hello',
            //           pid: '1212',
            //           // scd: dotenv.env['ESEWA_SCD']!
            //         ));
            //     // final result = await fakeEsewa();
            //     if (result.hasData) {
            //       final response = result.data!;
            //       if (kDebugMode) {
            //         print(response.toJson());
            //       }
            //     } else {
            //       if (kDebugMode) {
            //         print(result.error);
            //       }
            //     }
            //   },
            //   child: const Text('Pay with Esewa'),
            // ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
