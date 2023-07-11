import 'package:flutter/material.dart';
import '../controllers/knapsack_controller.dart';
import '../models/item.dart';
import 'capacity_page.dart';

class MochilaPage extends StatefulWidget {
  final int capacidadeMochila;
  const MochilaPage({Key? key, required this.capacidadeMochila}) : super(key: key);

  @override
  MochilaPageState createState() => MochilaPageState();
}

class MochilaPageState extends State<MochilaPage> {
  List<Item> itens = [];
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();

  bool resolvido = false;

  void adicionarItem() {
    String nome = nomeController.text;
    int valor = int.tryParse(valorController.text) ?? 0;
    int peso = int.tryParse(pesoController.text) ?? 0;

    setState(() {
      itens.add(Item(nome, valor, peso));
      nomeController.clear();
      valorController.clear();
      pesoController.clear();
      resolvido = false;
    });
  }

  void resolverProblema() {
    MochilaController mochilaController = MochilaController();
    int valorMaximo = mochilaController.knapsackPD(itens, widget.capacidadeMochila);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado da Mochila'),
          content: Text('Valor máximo: $valorMaximo'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  itens.clear();
                  resolvido = true;
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => CapacidadePage()),
                  (route) => false,
                );
              },
              child: const Text('Reiniciar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knapsack'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do item'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor do item'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Peso do item'),
            ),
          ),
          ElevatedButton(
            onPressed: adicionarItem,
            child: const Text('Adicionar item'),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: resolvido ? null : resolverProblema,
            child: resolvido ? const Text('Reiniciar') : const Text('Resolver'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = itens[index];
                return ListTile(
                  title: Text(item.nome),
                  subtitle: Text('Valor: ${item.valor}, Peso: ${item.peso}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
