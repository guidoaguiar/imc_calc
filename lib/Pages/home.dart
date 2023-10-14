import 'package:flutter/material.dart';
import 'package:imc_calc/Pages/results.dart';
import 'package:imc_calc/Service/base_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";
  List<IMCInfo> imcRecords = [];

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    String dateTime =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}";

    IMCInfo info = IMCInfo(weight, height, dateTime, imc);
    imcRecords.add(info);

    if (imc < 18.0) {
      _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      _infoText = "Peso Ideal(${imc.toStringAsPrecision(4)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      _infoText = "Levemente Acima do Peso(${imc.toStringAsPrecision(4)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(4)})";
    } else if (imc >= 40) {
      _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(4)})";
    }
  }

  void _showRecords() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IMCRecordsScreen(imcRecords)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
          IconButton(
            icon: const Icon(Icons.history_sharp),
            onPressed: _showRecords,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0),
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR84-NqzQDjo6MH99ln2Vzjpum9eHcBKjw-bTcPWM6EXpxmpAEhzGUpvAMn6hOroBnnGIU&usqp=CAU",
                height: 200,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.purpleAccent)),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.purpleAccent, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.purpleAccent)),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.purpleAccent, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc) {
                              _calculate();
                              return SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        _infoText,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      const SizedBox(height: 20.0),
                                      const Text(
                                        "Abaixo do Peso entre 18.6 e 24.9\nPeso Ideal entre 18.6 e 24.9\nLevemente Acima do Peso entre 24.9 e 29.9\nObesidade Grau I entre 29.9 e 34.9\nObesidade Grau II entre 34.9 e 39.9\nObesidade Grau III acima de 40",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              const Text(
                "Informe seus dados acima e clique em Calcular!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 100),
              Center(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    TextButton.icon(
                      onPressed: _showRecords,
                      icon: const Icon(Icons.history),
                      label: const Text("IMCs Anteriores"),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
