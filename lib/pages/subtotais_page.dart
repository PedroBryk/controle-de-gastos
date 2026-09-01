import 'package:contador_de_gastos/enum/gasto.dart';
import 'package:contador_de_gastos/enum/category_type.dart';
import 'package:flutter/material.dart';

class SubtotaisPage extends StatelessWidget {
  final List<Gasto> gastos;

  const SubtotaisPage({super.key, required this.gastos});

  @override
  Widget build(BuildContext context) {
    final total = calcularTotal(gastos);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subtotais por Categoria",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: CategoryType.values.map((categoria) {
            final subtotal = calcularSubtotal(gastos, categoria);
            final percentual = total > 0 ? subtotal / total : 0.0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 90, child: Text(categoria.label)),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: percentual,
                        backgroundColor: categoria.cor.withOpacity(0.15),
                        color: categoria.cor,
                        minHeight: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("${(percentual * 100).toStringAsFixed(0)}%"),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}