import 'package:fire_trade_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_trade_app/models/prediction.dart';
import 'package:fire_trade_app/widgets/predict_tile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ResultsScreen extends StatefulWidget {
  static const String id = 'results_screen';

  final previousJson;

  ResultsScreen({this.previousJson});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final _auth = FirebaseAuth.instance;
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

  _logOut() async {
    await _auth.signOut().then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          WelcomeScreen.id, ModalRoute.withName(WelcomeScreen.id));
    });
  }

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
          /*IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _logOut();
                //Implement logout functionality
              }),*/
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              _logOut();
            },
            child: Text(
              "Log out",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[100],
              ),
            ),
          ),
        ],
        title: Text('Predictions'),
        centerTitle: true,
        backgroundColor: Color(0xFF81C525),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                'AI Recommendations for Tomorrow',
                style: TextStyle(
                  color: Color(0xFFB7D9A3),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Color(0xFFB7D9A3),
            ),
            FutureBuilder(
              future: _predictions(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    padding: EdgeInsets.all(15.0),
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
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Color(0xFF19191E),
                          valueColor: AlwaysStoppedAnimation(Color(0xFF81C525)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Loading, please wait...",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16.0,
                          ),
                        ),
                      ],
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
}
