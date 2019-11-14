import 'package:flutter/material.dart';
import 'package:fire_trade_app/widgets/stocks_list.dart';
import 'package:fire_trade_app/models/stock.dart';
import 'package:fire_trade_app/screens/results_screen.dart';

class StocksScreen extends StatefulWidget {
  static const String id = 'stocks_screen';

  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  List<Stock> stocks = [
    Stock(name: 'AAPL'),
    Stock(name: 'AMZN'),
    Stock(name: 'BAC'),
    Stock(name: 'FB'),
    Stock(name: 'GM'),
    Stock(name: 'GOOGL'),
    Stock(name: 'JNJ'),
    Stock(name: 'NFLX'),
    Stock(name: 'SBUX'),
    Stock(name: 'XOM'),
  ];

  Map<String, String> _jsonRequest = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19191E),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 80.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset('assets/images/logo.png'),
                  height: 25.0,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'Select 5 Stocks from the list',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),

            //child: Image.asset('assets/images/logo.png'),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                //color: Colors.white,
                color: Color(0xFF19191E),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: StocksList(stocks),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Material(
              color: Color(0xFF81C525),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () {
                  //print(stocks[0].name);
                  /*var mappedNames =
                      stocks.map((n) => '${n.name} ${n.isSelected}');
                  mappedNames.forEach((n) => print(n));*/
                  for (var i = 0; i < stocks.length; i++) {
                    if (stocks[i].isSelected) {
                      _jsonRequest["$i"] = "${stocks[i].name}";
                    } else {
                      _jsonRequest.remove("$i");
                    }
                  }
                  print(_jsonRequest);
                  //makePostRequest(_jsonRequest);

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultsScreen(
                      previousJson: _jsonRequest,
                    );
                  }));
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Predict',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
