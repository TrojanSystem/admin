class OrderModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String date;
  final String orderedKilo;
  final String pricePerKG;
  final String totalAmount;
  final String remain;
  OrderModel({
    this.id,
    this.name,
    this.date,
    this.orderedKilo,
    this.phoneNumber,
    this.pricePerKG,
    this.remain,
    this.totalAmount,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'date': date,
      'orderedKilo': orderedKilo,
      'pricePerKG': pricePerKG,
      'totalAmount': totalAmount,
      'remain': remain,
    };
  }

  static OrderModel fromMap(Map<String, dynamic> map) {
    return OrderModel(
        id: map['id'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
        date: map['date'],
        orderedKilo: map['orderedKilo'],
        pricePerKG: map['pricePerKG'],
        totalAmount: map['totalAmount'],
        remain: map['remain']);
  }
}
