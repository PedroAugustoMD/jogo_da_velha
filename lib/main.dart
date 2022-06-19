import 'package:flutter/material.dart';
import 'package:jogo_da_velha/utils.dart';
import 'package:jogo_da_velha/models/jogador.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
