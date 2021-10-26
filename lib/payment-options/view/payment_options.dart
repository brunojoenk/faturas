import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:faturas/payment-options/model/payment_options_model.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

class PayWithCreditCard extends StatelessWidget {
  const PayWithCreditCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento da fatura'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: PaymentOptionsScreen(),
      ),
      bottomNavigationBar: Row(
        children: [
          OutlinedButton(
            child: const Text('Voltar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Text("1 de 3"),
          const Spacer(),
          ElevatedButton(
            child: const Text('Continuar'),
            onPressed: () {
              /** */
            },
          ),
        ],
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentOptionsScreen> createState() =>
      _PaymentOptionsScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  PaymentOptionsViewModel paymentOptionsViewModel =
      PaymentOptionsViewModel(paymentOptionsModel: PaymentOptionsModel());
  late PaymentOption selectedPaymentOption =
      paymentOptionsViewModel.paymentOptions[0];

  late double operationTax =
      (selectedPaymentOption.number * selectedPaymentOption.value) -
          paymentOptionsViewModel.invoiceValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Escolha o numero de parcelas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: paymentOptionsViewModel.paymentOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 20,
                child: RadioListTile<PaymentOption>(
                  title: Row(
                    children: [
                      Text(paymentOptionsViewModel.paymentOptions[index].number
                              .toString() +
                          'x ' +
                          numberFormat.format(paymentOptionsViewModel
                              .paymentOptions[index].value)),
                      const Spacer(),
                      Text(numberFormat
                          .format(paymentOptionsViewModel.paymentOptions[index].total)),
                    ],
                  ),
                  value: paymentOptionsViewModel.paymentOptions[index],
                  groupValue: selectedPaymentOption,
                  onChanged: (PaymentOption? value) {
                    setState(() {
                      selectedPaymentOption = value!;
                      paymentOptionsViewModel.setInvoiceValue(
                          selectedPaymentOption.total - operationTax);
                    });
                  },
                ),
              );
            },
          ),
        ),
        Card(
            elevation: 20,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Fatura de juhno'),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(numberFormat
                            .format(paymentOptionsViewModel.invoiceValue)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Taxa de operacao'),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(numberFormat.format( operationTax)),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
