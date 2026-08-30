import 'package:contador_de_gastos/enum/category_type.dart';
// representa um gasto cadastrado, com descrição, valor e categoria
class Gasto {
  final String descricao;
  final double valor;
  final CategoryType categoria;

  Gasto({
    required this.descricao,
    required this.valor,
    required this.categoria,
  });
}

// função que converte o texto digitado (tipo "12,50") em número (12.50).
double parseValor(String texto) {
  // aqui trocamos a virgula por ponto
  String textoComPonto = texto.replaceAll(',', '.');
  // aqui define o padrão e acha o numero
  RegExp regExp = RegExp(r'[0-9]+\.?[0-9]*');
  var match = regExp.firstMatch(textoComPonto);
  // aqui converte o texto para double (se não achar número, assume 0 para não travar o app)
  return double.parse(match?.group(0) ?? '0');
}

// a função recebe a lista inteira de gastos e devolve a soma de todos os valores.
double calcularTotal(List<Gasto> gastos) {
  double total = 0.0;
  for (var gasto in gastos) {
    total = total + gasto.valor;
  }
  return total;
}