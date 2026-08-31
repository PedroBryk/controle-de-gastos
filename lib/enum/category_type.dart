// aqui as categorias possíveis para um gasto, cada uma com um nome de exibição (label)
import 'package:flutter/material.dart';

enum CategoryType {
  alimentacao(label: "Alimentação", cor: Colors.amber, icone: Icons.restaurant),
  transporte(label: "Transporte", cor: Colors.lightBlue, icone: Icons.directions_car),
  lazer(label: "Lazer", cor: Colors.green, icone: Icons.sports_esports),
  outros(label: "Outros", cor: Colors.deepPurple, icone: Icons.category);

  final String label;
  final Color cor;
  final IconData icone;

  const CategoryType({required this.label, required this.cor, required this.icone});
}