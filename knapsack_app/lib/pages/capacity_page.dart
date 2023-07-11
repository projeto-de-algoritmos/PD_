import 'package:flutter/material.dart';
import 'knapsack_page.dart';

class CapacidadePage extends StatelessWidget {
  final TextEditingController capacidadeController = TextEditingController();

  CapacidadePage({super.key});

  void inserirItens(BuildContext context) {
    int capacidade = int.tryParse(capacidadeController.text) ?? 100;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MochilaPage(capacidadeMochila: capacidade)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capacidade da Mochila'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: capacidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Capacidade da Mochila'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => inserirItens(context),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
