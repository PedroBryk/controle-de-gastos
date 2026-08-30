import 'package:contador_de_gastos/enum/gasto.dart';
import 'package:contador_de_gastos/enum/category_type.dart';
import 'package:flutter/material.dart';

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
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            removerGasto(index);
                          },
                        ),
                      ],
                    ),
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
