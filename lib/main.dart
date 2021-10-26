import 'package:faturas/payment-options/view/payment_options.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes - Faturas',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Faturas(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/pay-with-credit-card': (context) => const PaymentOptionsScreen(),
      },
    );
  }
}

showNotImplementedDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Erro"),
    content: const Text("Não implementado..."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Faturas extends StatelessWidget {
  const Faturas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Faturas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Text("Última fatura",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("R\$ 3.025,49",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 8),
                            child: Text("Vencimento 08/07/2019",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.6))),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text("Vencida",
                          style: TextStyle(fontSize: 18, color: Colors.red))
                    ],
                  ),
                  const Divider(color: Colors.black),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("Formas de Pagamento",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text("Boleto Bancário",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.6))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Copiar código de barras do boleto'),
                      ),
                      onPressed: () {
                        showNotImplementedDialog(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Enviar boleto por e-mail'),
                      ),
                      onPressed: () {
                        showNotImplementedDialog(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text("Cartão de Crédito",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.6))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Pagar com cartão de crédito'),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/pay-with-credit-card');
                      },
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
