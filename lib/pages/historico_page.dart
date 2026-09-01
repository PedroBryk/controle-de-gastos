import 'package:contador_de_gastos/enum/gasto.dart';
import 'package:contador_de_gastos/widgets/gasto_card.dart';
import 'package:flutter/material.dart';

class HistoricoPage extends StatelessWidget {
  final List<Gasto> gastos;

  const HistoricoPage({super.key, required this.gastos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Histórico",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (gastos.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("Nenhum gasto registrado."),
              )
            else
              ...gastos.map(
                (gasto) => GastoCard(
                  gasto: gasto,
                  onDelete: () {},
                  showDelete: false, // histórico não exclui, só exibe
                ),
              ),
          ],
        ),
      ),
    );
  }
}