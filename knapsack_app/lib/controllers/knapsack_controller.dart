import '../models/item.dart';

class MochilaController {
  int knapsackPD(List<Item> itens, int capacidadeMochila) {
    List<List<int>> matrizValores = List.generate(
      itens.length + 1,
      (index) => List<int>.filled(capacidadeMochila + 1, 0),
    );

    for (int i = 1; i <= itens.length; i++) {
      for (int j = 1; j <= capacidadeMochila; j++) {
        if (itens[i - 1].peso <= j) {
          matrizValores[i][j] = 
            (itens[i - 1].valor + matrizValores[i - 1][j - itens[i - 1].peso]) > matrizValores[i - 1][j]
              ? (itens[i - 1].valor + matrizValores[i - 1][j - itens[i - 1].peso])
              : matrizValores[i - 1][j];
        } else {
          matrizValores[i][j] = matrizValores[i - 1][j];
        }
      }
    }

    return matrizValores[itens.length][capacidadeMochila];
  }
}