import 'package:flutter/material.dart';
import 'package:fire_trade_app/widgets/stock_tile.dart';
import 'package:fire_trade_app/models/stock.dart';

class StocksList extends StatefulWidget {
  final List<Stock> stocks;

  StocksList(this.stocks);

  @override
  _StocksListState createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return StockTile(
            stockTitle: widget.stocks[index].name,
            isChecked: widget.stocks[index].isSelected,
            checkboxCallback: (checkboxState) {
              setState(() {
                widget.stocks[index].toggleSelected();
              });
            });
      },
      itemCount: widget.stocks.length,
    );
  }
}
