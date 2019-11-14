import 'package:flutter/material.dart';
import 'package:new_stocks_page/models/prediction.dart';
import 'package:new_stocks_page/widgets/predict_tile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ResultsScreen extends StatefulWidget {
  final previousJson;

  ResultsScreen({this.previousJson});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<Prediction> predictions = [];
  Future<List<Prediction>> _predictions() async {
    String url = "https://predict-stock-57p5.onrender.com/";
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    var jsonText = jsonEncode(widget.previousJson);
    var response = await post(url, headers: headers, body: jsonText);
    //int statusCode = response.statusCode;
    final dynamic data = json.decode(response.body);

    var key;
    for (key in data.keys) {
      print(data[key][1]);
      predictions.add(Prediction(name: data[key][0], predict: data[key][1]));
    }
    return predictions;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: _predictions(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xFF19191E),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PredictTile(
                          stockTitle: predictions[index].name,
                          prediction: predictions[index].predict,
                        );
                      },
                    ),
                    //child: Text('It works'),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child: Text("Loading..."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  /*Widget build(BuildContext context) {
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
        title: Text('Predictions'),
        backgroundColor: Color(0xFF81C525),
      ),
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
                  'AI Recommendations for Tomorrow',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
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
              child: PredictsList(predictions),
            ),
          ),
        ],
      ),
    );
  }*/
}
