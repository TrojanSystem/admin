class ContractModel {
  final String name;
  final String date;
  final String quantity;
  final String price;
  ContractModel({this.name, this.date, this.quantity, this.price});
  Map<String, dynamic> toMap() {
    return {'name': name, 'date': date, 'quantity': quantity, 'price': price};
  }

  static ContractModel fromMap(Map<String, dynamic> map) {
    return ContractModel(
        name: map['name'],
        date: map['date'],
        quantity: map['quantity'],
        price: map['price']);
  }
}

class DailyProductionModel {
  final String bale_5;
  final String bale_10;
  final String slice;
  final String bombolino;
  DailyProductionModel({this.bale_5, this.bale_10, this.slice, this.bombolino});
}
