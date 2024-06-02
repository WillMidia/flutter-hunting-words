import 'package:flutter/material.dart';

class CongratulationsScreen extends StatelessWidget {
  final VoidCallback onPlayAgain;

  CongratulationsScreen({required this.onPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parabéns!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            Text(
              'Parabéns, você encontrou todas as palavras!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPlayAgain,
              child: Text('Jogar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
