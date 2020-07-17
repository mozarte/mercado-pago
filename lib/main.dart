import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

void main() => runApp(MyApp());


// Get your app public from the credentials pages:
// https://www.mercadopago.com/mla/account/credentials
const publicKey = "TEST-df476eb9-d8c0-4c35-8762-d6d8f9627f4b";

// The preferenceId should be fetch from your backend server. Do not
// expose your Access Token. Also you can create a preference using
// curl:
// ```bash
// curl -X POST \
//     'https://api.mercadopago.com/checkout/preferences?access_token=ACCESS_TOKEN' \
//     -H 'Content-Type: application/json' \
//     -d '{
//           "items": [
//               {
//               "title": "Dummy Item",
//               "description": "Multicolor Item",
//               "quantity": 1,
//               "currency_id": "ARS",
//               "unit_price": 10.0
//               }
//           ],
//           "payer": {
//               "email": "payer@email.com"
//           }
//     }'
// ```
const preferenceId = "478735065-18810a31-4d5b-4c8d-9494-04d9fdd7ec70";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MercadoPagoMobileCheckout.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black),
      home: Scaffold(
        
        appBar: AppBar(
          title: const Text('Mercado pago'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              FlatButton(
                onPressed: () async {
                  PaymentResult result =
                      await MercadoPagoMobileCheckout.startCheckout(
                    publicKey,
                    preferenceId,
                  );
                  print(result.toString());
                },
                child: Text("Pagar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}