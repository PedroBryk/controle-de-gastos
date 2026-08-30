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
        title: const Text(
          "Contador de Gastos",
          style: TextStyle(fontWeight: FontWeight.bold),
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
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: valorController,
              decoration: const InputDecoration(labelText: "Valor"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: adicionarGasto,
              child: const Text("Adicionar Gasto"),
            ),
            const SizedBox(height: 10),
            Text(
              "Total: R\$ ${calcularTotal(gastos).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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