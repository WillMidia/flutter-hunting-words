import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palavra_caca/screens/congratulation_screen.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> palavras = ['FLUTTER', 'DART', 'MOBILE', 'APP'];
  final int gridSize = 8;
  late List<List<String>> grid;
  Map<String, String> wordDescriptions = {
    'FLUTTER': 'Um SDK para desenvolvimento de aplicativos móveis.',
    'DART': 'Uma linguagem de programação otimizada para aplicativos da web.',
    'MOBILE': 'Relacionado a dispositivos móveis.',
    'APP': 'Abreviação de aplicativo.',
  };

  List<Offset> selectedCells = [];
  Set<String> foundWords = {};
  Set<Offset> highlightedCells = {};
  Offset? startDrag;
  Offset? endDrag;

  @override
  void initState() {
    super.initState();
    grid = _generateGrid(gridSize, palavras);
  }

  List<List<String>> _generateGrid(int size, List<String> words) {
    List<List<String>> grid = List.generate(
      size,
      (_) => List.generate(size, (_) => '', growable: false),
      growable: false,
    );
    Random random = Random();

    for (var word in words) {
      int startX, startY;
      bool placed = false;

      while (!placed) {
        startX = random.nextInt(size);
        startY = random.nextInt(size);
        bool horizontal = random.nextBool();

        if (horizontal) {
          if (startX + word.length <= size) {
            bool canPlace = true;
            for (int i = 0; i < word.length; i++) {
              if (grid[startY][startX + i] != '' &&
                  grid[startY][startX + i] != word[i]) {
                canPlace = false;
                break;
              }
            }
            if (canPlace) {
              for (int i = 0; i < word.length; i++) {
                grid[startY][startX + i] = word[i];
              }
              placed = true;
            }
          }
        } else {
          if (startY + word.length <= size) {
            bool canPlace = true;
            for (int i = 0; i < word.length; i++) {
              if (grid[startY + i][startX] != '' &&
                  grid[startY + i][startX] != word[i]) {
                canPlace = false;
                break;
              }
            }
            if (canPlace) {
              for (int i = 0; i < word.length; i++) {
                grid[startY + i][startX] = word[i];
              }
              placed = true;
            }
          }
        }
      }
    }

    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        if (grid[y][x] == '') {
          grid[y][x] = String.fromCharCode(
            random.nextInt(26) + 65, // Letras maiúsculas A-Z
          );
        }
      }
    }

    return grid;
  }

  void _onPanStart(DragStartDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    startDrag = box.globalToLocal(details.localPosition);
    setState(() {
      selectedCells = [];
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    endDrag = box.globalToLocal(details.localPosition);
    List<Offset> newSelectedCells = _calculateSelectedCells();
    if (!listEquals(selectedCells, newSelectedCells)) {
      setState(() {
        selectedCells = newSelectedCells;
      });
    }
  }

void _onPanEnd(DragEndDetails details) {
  setState(() {
    String selectedWord = _getSelectedWord();
    if (palavras.contains(selectedWord)) {
      foundWords.add(selectedWord);
      highlightedCells.addAll(selectedCells);
      _showWordDialog(selectedWord);
    }
    selectedCells = [];
    startDrag = null;
    endDrag = null;
  });
}

List<Offset> _calculateSelectedCells() {
  if (startDrag == null || endDrag == null) return [];

  List<Offset> cells = [];
  double cellWidth = 40; // Tamanho fixo da célula
  double cellHeight = 40; // Tamanho fixo da célula

  int startX = (startDrag!.dx / cellWidth).floor();
  int startY = (startDrag!.dy / cellHeight).floor();
  int endX = (endDrag!.dx / cellWidth).floor();
  int endY = (endDrag!.dy / cellHeight).floor();

  int dx = endX - startX;
  int dy = endY - startY;

  // Determine a direção principal do movimento
  bool isHorizontal = dx.abs() > dy.abs();
  bool isVertical = dy.abs() > dx.abs();
  bool isDiagonal = dx.abs() == dy.abs();

  int steps;
  if (isHorizontal) {
    steps = dx.abs();
  } else if (isVertical) {
    steps = dy.abs();
  } else {
    steps = dx.abs(); // ou dy.abs(), já que ambos são iguais em uma diagonal
  }

  for (int i = 0; i <= steps; i++) {
    int x, y;
    if (isHorizontal) {
      x = startX + dx.sign * i;
      y = startY;
    } else if (isVertical) {
      x = startX;
      y = startY + dy.sign * i;
    } else {
      x = startX + dx.sign * i;
      y = startY + dy.sign * i;
    }
    cells.add(Offset(x.toDouble(), y.toDouble()));
  }

  return cells;
}

String _getSelectedWord() {
  String word = '';
  for (var cell in selectedCells) {
    int x = cell.dx.toInt();
    int y = cell.dy.toInt();
    word += grid[y][x];
  }
  return word;
}

Future<void> _showWordDialog(String word) async {
  final result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Parabéns! Você encontrou: $word'),
        content: Text(wordDescriptions[word]!),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              foundWords.add(word);
              highlightedCells.addAll(selectedCells);
              if (foundWords.length == palavras.length) {
                Future.delayed(Duration.zero, () {
                  _navigateToCongratulationsScreen();
                });
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void _navigateToCongratulationsScreen() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CongratulationsScreen(
        onPlayAgain: _resetGame,
      ),
    ),
  );
}

void _resetGame() {
  setState(() {
    grid = _generateGrid(gridSize, palavras);
    foundWords.clear();
    highlightedCells.clear();
    selectedCells.clear();
    startDrag = null;
    endDrag = null;
  });
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    double cellWidth = 40; // Tamanho fixo da célula
    double cellHeight = 40; // Tamanho fixo da célula

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: cellWidth * gridSize,
                height: cellHeight * gridSize,
                child: GestureDetector(
                  onPanStart: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(), // Evita o scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      int x = index % gridSize;
                      int y = index ~/ gridSize;
                      bool isSelected = selectedCells
                          .contains(Offset(x.toDouble(), y.toDouble()));
                      bool isHighlighted = highlightedCells
                          .contains(Offset(x.toDouble(), y.toDouble()));

                      return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8.0), // Raio de 8.0 (ajuste conforme necessário)
                          child: AnimatedContainer(
                                                        duration: Duration(
                                milliseconds:
                                    200), // Duração da animação em milissegundos
                            curve: Curves
                                .easeInOut, // Ajuste a curva de animação conforme desejado
                            margin: EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              color: isSelected || isHighlighted ? Colors.orange : Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                grid[y][x],
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: isSelected || isHighlighted
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ));
                    },
                    itemCount: gridSize * gridSize,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: palavras.map((word) {
                bool isFound = foundWords.contains(word);
                return GestureDetector(
                  onTap: () {
                    if (isFound) {
                      _showWordDialog(word);
                    }
                  },
                  child: Chip(
                    label: Text(
                      word,
                      style: TextStyle(
                        fontWeight: isFound ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    backgroundColor: isFound ? Colors.orange : null,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
