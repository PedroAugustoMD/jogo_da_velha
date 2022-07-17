import 'package:jogo_da_velha/models/jogador.dart';
import 'package:jogo_da_velha/pages/game_view.dart';
import 'package:jogo_da_velha/models/observable.dart';

class JogoDaVelha implements Observable {
  static const contTabuleiro = 3;
  static const double tamanho = 92;
  String ultimaJogada = Jogador.none;
  late List<List<String>> tabuleiro;

  @override
  void notifyObserver(
      String valor, List<List<String>> tabuleiro, int x, int y) {
    ultimaJogada = valor;
    tabuleiro[x][y] = valor;
  }

  void setCamposVazios(GameView view) =>
      view.setState(() => tabuleiro = List.generate(
            contTabuleiro,
            (_) => List.generate(contTabuleiro, (_) => Jogador.none),
          ));

  void selecionarCampo(String valor, int x, int y, GameView view) {
    if (valor == Jogador.none) {
      final novoValor = ultimaJogada == Jogador.X ? Jogador.O : Jogador.X;
      notifyObserver(novoValor, tabuleiro, x, y);
      view.update();
      if (venceu(x, y)) {
        view.terminou('Jogador $novoValor ganhou!');
      } else if (empate()) {
        view.terminou('Empate');
      }
    }
  }

  bool empate() => tabuleiro
      .every((values) => values.every((value) => value != Jogador.none));

  /// Check out logic here: https://stackoverflow.com/a/1058804
  bool venceu(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = tabuleiro[x][y];
    const n = contTabuleiro;

    for (int i = 0; i < n; i++) {
      if (tabuleiro[x][i] == player) col++;
      if (tabuleiro[i][y] == player) row++;
      if (tabuleiro[i][i] == player) diag++;
      if (tabuleiro[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }
}
