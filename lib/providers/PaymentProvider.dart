import 'package:flutter/material.dart';

import '../Model/PaymentObject.dart';

class PaymentProvider with ChangeNotifier {
  //list of payment components
  PaymentItemObject paymentItemObject;

  PaymentProvider(this.paymentItemObject);

  void setTitle(String title) {
    paymentItemObject.title = title;
    notifyListeners();
  }

  void setPrice(double price) {
    paymentItemObject.price = price;
    notifyListeners();
  }

  void setDate(DateTime date) {
    paymentItemObject.date = date;
    notifyListeners();
  }

  void setDescription(String description) {
    paymentItemObject.description = description;
    notifyListeners();
  }
}
