import 'package:flutter/material.dart';
import 'package:jogo_da_velha/utils.dart';
import 'package:jogo_da_velha/models/jogador.dart';
import 'package:jogo_da_velha/pages/game_page.dart';
import 'package:jogo_da_velha/pages/game_view.dart';

class JogoDaVelha extends State<MyHomePage> {
  static const contTabuleiro = 3;
  static const double tamanho = 92;
  String ultimaJogada = Jogador.none;
  late List<List<String>> tabuleiro;
  GameView view = GameView();

  @override
  void initState() {
    super.initState();

    setCamposVazios();
  }

  void setCamposVazios() => setState(() => tabuleiro = List.generate(
        contTabuleiro,
        (_) => List.generate(contTabuleiro, (_) => Jogador.none),
      ));

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: view.getCorFundo(this),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Utils.modelBuilder(
              tabuleiro, (x, value) => view.construirLinha(x, this)),
        ),
      );

  void selecionarCampo(String valor, int x, int y) {
    if (valor == Jogador.none) {
      final novoValor = ultimaJogada == Jogador.X ? Jogador.O : Jogador.X;

      setState(() {
        ultimaJogada = novoValor;
        tabuleiro[x][y] = novoValor;
      });
      if (venceu(x, y)) {
        view.terminou('Jogador $novoValor ganhou!', this);
      } else if (empate()) {
        view.terminou('Empate', this);
      }
    }
  }

  bool empate() => tabuleiro
      .every((values) => values.every((value) => value != Jogador.none));

  /// Lógica: https://stackoverflow.com/a/1058804
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
