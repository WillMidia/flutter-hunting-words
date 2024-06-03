import 'package:flutter/material.dart';
import 'package:palavra_caca/screens/game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caça-Palavras do Oceano'),
        backgroundColor: Color(0xFF006994), // Cor de fundo azul oceano
      ),
      backgroundColor: Color(0xFFB2EBF2), // Cor de fundo azul claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animationController.drive(
                CurveTween(curve: Curves.easeInOutBack),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.waves,
                    size: 100,
                    color: Color(0xFF006994), // Cor azul oceano
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Caça-Palavras OCEAN20',
                    style: TextStyle(
                      fontSize: 36, // Aumenta o tamanho da fonte
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006994), // Cor azul oceano
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Color(0xFF006994), // Cor azul oceano
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Começar Jogo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF006994),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Desenvolvido por:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                   'RM - ALUNO\N RM - ALUNO\n RM - ALUNO',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
