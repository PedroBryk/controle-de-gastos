import 'package:contador_de_gastos/enum/gasto.dart';
import 'package:contador_de_gastos/enum/category_type.dart';
import 'package:flutter/material.dart';
import 'package:contador_de_gastos/widgets/gasto_card.dart';
import 'package:contador_de_gastos/pages/historico_page.dart';

class GastosPage extends StatefulWidget {
  const GastosPage({super.key});

  @override
  State<GastosPage> createState() => _GastosPageState();
}

class _GastosPageState extends State<GastosPage> {
  late List<Gasto> gastos;
  late TextEditingController descricaoController;
  late TextEditingController valorController;
  late CategoryType categoriaSelecionada;

  @override
  void initState() {
    super.initState();
    gastos = [];
    descricaoController = TextEditingController();
    valorController = TextEditingController();
    categoriaSelecionada = CategoryType.alimentacao;
  }

  //adicionar um gasto na lista de gastos
  void adicionarGasto() {
    setState(() {
      Gasto novoGasto = Gasto(
        descricao: descricaoController.text, //pega o texto atual do campo
        valor: parseValor(
          valorController.text,
        ), //converte o texto do valor pra número
        categoria: categoriaSelecionada,
      );
      gastos.add(novoGasto);
      descricaoController.clear();
      valorController.clear();
    });
  }

  //excluir um gasto.
  void removerGasto(int index) {
    setState(() {
      gastos.removeAt(index);
    });
  }

  // aqui começa a tela principal: formulário de novo gasto + lista de gastos cadastrados
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet),
            SizedBox(width: 8),
            Text(
              "Contador de Gastos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoricoPage(gastos: gastos),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(
                labelText: "Descrição",
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: valorController,
              decoration: const InputDecoration(
                labelText: "Valor",
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<CategoryType>(
                  value: categoriaSelecionada,
                  items: CategoryType.values.map((categoria) {
                    return DropdownMenuItem(
                      value: categoria,
                      child: Text(categoria.label),
                    );
                  }).toList(),
                  onChanged: (novaCategoria) {
                    setState(() {
                      categoriaSelecionada = novaCategoria!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: adicionarGasto,
                  child: const Text("Adicionar Gasto"),
                ),
                Text(
                  "Total: R\$ ${calcularTotal(gastos).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ...CategoryType.values.map((categoria) {
              final subtotal = calcularSubtotal(gastos, categoria);
              final total = calcularTotal(gastos);
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
            }),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: gastos.length,
                itemBuilder: (context, index) {
                  final gasto = gastos[index];
                  return GastoCard(
                    gasto: gasto,
                    onDelete: () {
                      removerGasto(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
