import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:fire_trade_app/screens/results_screen.dart';
//import 'package:fire_trade_app/constants.dart';

class StockScreen extends StatefulWidget {
  static const String id = 'stocks_screen';

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  bool checkboxValueCity = false;
  List<String> allItems = ['GOOGL', 'AAPL', 'AMZN', 'SBUX', 'NFLX', 'FB'];
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF19191E),
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('Stocks'),
        backgroundColor: Color(0xFF81C525),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 20.0,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 12.0,
              ),
              FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return _MyDialog(
                              items: allItems,
                              selectedItems: selectedItems,
                              onSelectedItemsListChanged: (items) {
                                selectedItems = items;
                                //print(selectedItems);
                              });
                        });
                  },
                  label: Text('Select Stocks'),
                  icon: Icon(Icons.pie_chart), //thumb_up
                  backgroundColor: (Color(0xFFB7D9A3))),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyDialog extends StatefulWidget {
  _MyDialog({
    this.items,
    this.selectedItems,
    this.onSelectedItemsListChanged,
  });

  final List<String> items;
  final List<String> selectedItems;

  final ValueChanged<List<String>> onSelectedItemsListChanged;
  List<String> get listdata => this.selectedItems; // To ensure readonly
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<String> _tempSelectedItems = [];
  Map<String, String> _jsonRequest = {};
  String _result;
  final String _body = "data";

  @override
  void initState() {
    _tempSelectedItems = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Commodities',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final commodityName = widget.items[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(commodityName),
                        value: _tempSelectedItems.contains(commodityName),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedItems.contains(commodityName)) {
                              setState(() {
                                _tempSelectedItems.add(commodityName);
                              });
                            }
                          } else {
                            if (_tempSelectedItems.contains(commodityName)) {
                              setState(() {
                                _tempSelectedItems.removeWhere(
                                    (String commodity) =>
                                        commodity == commodityName);
                              });
                            }
                          }
                          widget.onSelectedItemsListChanged(_tempSelectedItems);
                        }),
                  );
                }),
          ),
          FloatingActionButton.extended(
              onPressed: () {
                //print(_result);
                if (_tempSelectedItems.contains("GOOGL")) {
                  _jsonRequest["0"] = "GOOGL";
                }
                if (_tempSelectedItems.contains("AAPL")) {
                  _jsonRequest["1"] = "AAPL";
                }
                if (_tempSelectedItems.contains("AMZN")) {
                  _jsonRequest["2"] = "AMZN";
                }
                if (_tempSelectedItems.contains("SBUX")) {
                  _jsonRequest["3"] = "SBUX";
                }
                if (_tempSelectedItems.contains("NFLX")) {
                  _jsonRequest["4"] = "NFLX";
                }
                if (_tempSelectedItems.contains("FB")) {
                  _jsonRequest["5"] = "FB";
                }

                print(_jsonRequest);
                //print(_result);
                makePostRequest(_jsonRequest);
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyResults()),
                );*/

                var route = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ResultsPage(value: _result),
                );

                Navigator.of(context).push(route);
              },
              label: Text('Submit'),
              icon: Icon(Icons.pie_chart), //thumb_up
              backgroundColor: (Color(0xFFB7D9A3)))
        ],
      ),
    );
  }

  makePostRequest(requestData) async {
    // set up POST request arguments

    String url = "https://predict-stock-57p5.onrender.com/";
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    var jsonText = jsonEncode(requestData);
    var response = await post(url, headers: headers, body: jsonText);
    int statusCode = response.statusCode;
    String _body = response.body;
    print(statusCode);
    print(_body); // get the body of the request and send to the app page
    return _body;
  }

  void changeText() {
    setState(() => _result = _body);
  }
}

class ResultsPage extends StatefulWidget {
  final String value;

  ResultsPage({this.value});

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
      ),
      body: Text("$widget.value"),
    );
  }
}
