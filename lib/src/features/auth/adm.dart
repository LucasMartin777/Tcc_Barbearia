import 'package:flutter/material.dart';

class Adm extends StatefulWidget {

  const Adm({ super.key });

  @override
  State<Adm> createState() => _AdmState();
}

class _AdmState extends State<Adm> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('adm'),),
           body: Container(),
       );
  }
}