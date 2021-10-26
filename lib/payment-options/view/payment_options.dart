import 'package:faturas/payment-options/model/payment_option.dart';
import 'package:faturas/payment-options/model/payment_options_model.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<PaymentOptionsModel>(
          create: (_) => PaymentOptionsModel()),
      ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
        create: (context) => PaymentOptionsViewModel(
            paymentOptionsModel: context.read<PaymentOptionsModel>()),
        update: (context, paymentOptionsModel, notifier) =>
            PaymentOptionsViewModel(
              paymentOptionsModel: paymentOptionsModel,
            ),
      ),
    ], child: PaymentOptionsWidget());
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class PaymentOptionsWidget extends StatelessWidget {
  final _numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

  PaymentOptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento da fatura'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<PaymentOptionsViewModel>(
            builder: (context, paymentOptionsViewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Escolha o numero de parcelas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))),
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
                                Text(paymentOptionsViewModel
                                        .paymentOptions[index].number
                                        .toString() +
                                    'x ' +
                                    _numberFormat.format(paymentOptionsViewModel
                                        .paymentOptions[index].value)),
                                const Spacer(),
                                Text(_numberFormat.format(
                                    paymentOptionsViewModel
                                        .paymentOptions[index].total)),
                              ],
                            ),
                            value:
                                paymentOptionsViewModel.paymentOptions[index],
                            groupValue:
                                paymentOptionsViewModel.selectedPaymentOption,
                            onChanged: (PaymentOption? value) {
                              paymentOptionsViewModel.selectedPaymentOption =
                                  value!;
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
                                  child: Text(_numberFormat.format(
                                      paymentOptionsViewModel.invoiceValue)),
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
                                  child: Text(_numberFormat.format(
                                      paymentOptionsViewModel.operationTax)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              );
            },
          )),
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
