import 'package:flutter/material.dart';
import 'package:new_stocks_page/models/prediction.dart';
import 'package:new_stocks_page/widgets/predicts_list.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ResultsScreen extends StatefulWidget {
  final previousJson;

  ResultsScreen({this.previousJson});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
//  Map<String, dynamic> results;
//  List<Prediction> predictions = [
//    Prediction(name: 'AAPL', predict: 'SELL'),
//    Prediction(name: 'AMZN', predict: 'BUY'),
//    Prediction(name: 'BAC', predict: 'SELL'),
//    Prediction(name: 'FB', predict: 'SELL'),
//    Prediction(name: 'GOOGL', predict: 'BUY'),
//  ];
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

    print('Previous Json is: ${widget.previousJson}');
    _predictions();

    //makePostRequest(widget.previousJson);
    //Future.delayed(const Duration(seconds: 10));
  }

/*  makePostRequest(requestData) async {
    String url = "https://predict-stock-57p5.onrender.com/";
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    var jsonText = jsonEncode(requestData);
    var response = post(url, headers: headers, body: jsonText);
    //int statusCode = response.statusCode;
    //String _body = response.body;
    print(statusCode);
    //print(_body); // get the body of the request and send to the app page
    final dynamic data = json.decode(response.body);
    print(data);
    //print(data["AAPL"]);
    //results = await data;

    return results;
  }*/

/*  loadList(data) {
    var key;
    for (key in results.keys) {
      print(results[key][1]);
      predictions
          .add(Prediction(name: results[key][0], predict: results[key][1]));
    }
  }*/

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
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xfffF7F7F7),
                    /*child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookDetails(
                          snapshot.data[index],
                          snapshot.data[index].bookname,
                          snapshot.data[index].bookauthor,
                          snapshot.data[index].bookcover,
                          snapshot.data[index].bookrating,
                          snapshot.data[index].bookviews,
                        );
                      },
                    ),*/
                    child: Text('It works'),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text("Loading"),
                    ),
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
