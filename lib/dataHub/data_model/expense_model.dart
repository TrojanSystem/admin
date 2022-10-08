class ExpenseModel {
  final int id;
  final String itemName;
  final String itemPrice;
  final String itemDate;
  final String itemQuantity;
  final String total;

  ExpenseModel(
      {this.itemName,
      this.id,
      this.itemPrice,
      this.itemDate,
      this.itemQuantity,
      this.total});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemDate': itemDate,
      'itemQuantity': itemQuantity,
      'total': total
    };
  }

  static ExpenseModel fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map['id'],
        itemName: map['itemName'],
        itemQuantity: map['itemQuantity'],
        itemPrice: map['itemPrice'],
        itemDate: map['itemDate'],
        total: map['total']);
  }
}
