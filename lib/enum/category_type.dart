// aqui as categorias possíveis para um gasto, cada uma com um nome de exibição (label)
enum CategoryType {
  alimentacao(label: "Alimentação"),
  transporte(label: "Transporte"),
  lazer(label: "Lazer"),
  outros(label: "Outros");

  final String label;

  const CategoryType({required this.label});
}
