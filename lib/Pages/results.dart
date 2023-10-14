import 'package:flutter/material.dart';
import 'package:imc_calc/Service/base_info.dart';

class IMCRecordsScreen extends StatelessWidget {
  final List<IMCInfo> imcRecords;

  const IMCRecordsScreen(this.imcRecords, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text("Registros de IMC"),
      ),
      body: ListView.builder(
        itemCount: imcRecords.length,
        itemBuilder: (context, index) {
          IMCInfo record = imcRecords[index];
          return ListTile(
            title: Text("Data e Hora: ${record.dateTime}h"),
            subtitle: Text(
                "Peso: ${record.weight}, Altura: ${record.height}, IMC: ${record.imc.toStringAsFixed(1)}"),
          );
        },
      ),
    );
  }
}
