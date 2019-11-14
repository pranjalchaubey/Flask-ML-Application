class Stock {
  final String name;
  bool isSelected;

  Stock({this.name, this.isSelected = false});

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
