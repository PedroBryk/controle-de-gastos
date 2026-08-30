import 'package:contador_de_gastos/enum/gasto.dart';
import 'package:flutter/material.dart';

class GastoCard extends StatelessWidget {
  final Gasto gasto;
  final VoidCallback onDelete;
  final bool showDelete;

  const GastoCard({
    super.key,
    required this.gasto,
    required this.onDelete,
    this.showDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${gasto.descricao} - ${gasto.categoria.label} - R\$ ${gasto.valor.toStringAsFixed(2)}",
            ),
          ),
          if (showDelete)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}