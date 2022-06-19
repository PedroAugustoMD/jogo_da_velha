import 'package:flutter/material.dart';
import 'package:jogo_da_velha/utils.dart';
import 'package:jogo_da_velha/models/jogador.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const contTabuleiro = 3;
  static const double tamanho = 92;
  late List<List<String>> tabuleiro;

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
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              Utils.modelBuilder(tabuleiro, (x, value) => construirLinha(x)),
        ),
      );

  Widget construirLinha(int x) {
    final valores = tabuleiro[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        valores,
        (y, value) => construirCampo(x, y),
      ),
    );
  }

  Widget construirCampo(int x, int y) {
    final valor = tabuleiro[x][y];

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(tamanho, tamanho),
          primary: Colors.white,
        ),
        child: Text(valor, style: TextStyle(fontSize: 32)),
        onPressed: () {},
      ),
    );
  }
}