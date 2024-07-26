import 'package:flutter/material.dart';

class CommandePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commandes'),
      ),
      body: Center(
        child: Text('Ceci est la page des commandes'),
      ),
    );
  }
}

