import 'package:flutter/material.dart';
import 'package:jogo_da_velha/controllers/game_controller.dart';
import 'package:jogo_da_velha/models/jogador.dart';
import 'package:jogo_da_velha/utils.dart';
import 'package:jogo_da_velha/pages/game_page.dart';

class GameView extends State<MyHomePage> {
  JogoDaVelha controller = JogoDaVelha();

  Color getCorFundo() {
    final jogadaAtual =
        controller.ultimaJogada == Jogador.X ? Jogador.O : Jogador.X;
    return getCorCampo(jogadaAtual).withAlpha(150);
  }

  @override
  void initState() {
    super.initState();

    controller.setCamposVazios(this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: getCorFundo(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Utils.modelBuilder(
              controller.tabuleiro, (x, value) => construirLinha(x)),
        ),
      );

  Widget construirLinha(int x) {
    final valores = controller.tabuleiro[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        valores,
        (y, value) => construirCampo(x, y),
      ),
    );
  }

  void update() {
    setState(() {
      controller.ultimaJogada;
      controller.tabuleiro;
    });
  }

  Color getCorCampo(String valor) {
    switch (valor) {
      case Jogador.O:
        return Colors.blue;
      case Jogador.X:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Widget construirCampo(int x, int y) {
    final valor = controller.tabuleiro[x][y];
    final cor = getCorCampo(valor);

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(JogoDaVelha.tamanho, JogoDaVelha.tamanho),
          primary: cor,
        ),
        child: Text(valor, style: TextStyle(fontSize: 32)),
        onPressed: () => controller.selecionarCampo(valor, x, y, this),
      ),
    );
  }

  Future terminou(String titulo) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: Text('Pressione o botão para reiniciar o jogo'),
          actions: [
            ElevatedButton(
              onPressed: () {
                controller.setCamposVazios(this);
                Navigator.of(context).pop();
              },
              child: Text('Reiniciar'),
            )
          ],
        ),
      );
}
