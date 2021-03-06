import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:flutter/cupertino.dart';

List<PaymentOption> defaultPaymentOptions = [
  PaymentOption(1, 3180, 3180),
  PaymentOption(2, 1630, 3260),
  PaymentOption(3, 1086.67, 3260),
  PaymentOption(4, 815, 3260),
  PaymentOption(5, 662, 3310),
  PaymentOption(6, 551.67, 3310),
  PaymentOption(7, 472.86, 3310),
];

class PaymentOptionsModel extends ChangeNotifier {
  late double _invoiceValue;
  late PaymentOption _selectedPaymentOption = defaultPaymentOptions[0];
  final List<PaymentOption> _paymentOptions;

  PaymentOptionsModel()
      : _invoiceValue = 3025.49,
        _paymentOptions = defaultPaymentOptions{}

  double get invoiceValue => _invoiceValue;

  set invoiceValue(value) {
    _invoiceValue = value;
  }

  PaymentOption get selectedPaymentOption => _selectedPaymentOption;

  set selectedPaymentOption(value) {
    _selectedPaymentOption = value;

    notifyListeners();
  }

  List<PaymentOption> get paymentOptions {
    return _paymentOptions;
  }
}
