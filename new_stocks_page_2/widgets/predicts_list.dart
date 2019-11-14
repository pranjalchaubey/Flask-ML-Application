import 'package:flutter/material.dart';
import 'package:new_stocks_page/widgets/predict_tile.dart';
import 'package:new_stocks_page/models/prediction.dart';

class PredictsList extends StatefulWidget {
  final List<Prediction> predictions;

  PredictsList(this.predictions);

  @override
  _PredictsListState createState() => _PredictsListState();
}

class _PredictsListState extends State<PredictsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return PredictTile(
          stockTitle: widget.predictions[index].name,
          prediction: widget.predictions[index].predict,
        );
      },
      itemCount: widget.predictions.length,
    );
  }
}
