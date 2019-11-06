import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fire_trade_app/screens/stocks_screen.dart';

class SubscribeScreen extends StatefulWidget {
  static const String id = 'subscribe_screen';

  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  Razorpay _razorpay;

  @override
  initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_30uxz858pDwygw',
      'amount': 700,
      "method": "card",
      'name': 'Fire Trade',
      'description': 'Monthly subscription to Fire Trade',
      'prefill': {'contact': '', 'email': ''},
      //'external': {
        //'wallets': ['paytm']
      //}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19191E),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 30.0,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Subscribe to continue",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.grey[400]),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Enjoy access to all of our services by subscribing to our monthly plan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[400]
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFB7D9A3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.transparent,
                ),
                //color: Colors.grey[900],
                //height: 120,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text("LIMITED TIME OFFER",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB7D9A3),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text("MONTHLY \$ 9.99",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Recurring billing. Cancel anytime",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Color(0xFF81C525),
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      openCheckout();
                      Navigator.pushNamed(context, StockScreen.id);
                      },
                    //child: Text('Open'),
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Subscribe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

