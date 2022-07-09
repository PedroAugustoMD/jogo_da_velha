import 'package:flutter/material.dart';
import 'package:jogo_da_velha/pages/jogo_da_velha.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => JogoDaVelha();
}
