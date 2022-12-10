import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 50, 10, 196),
        body: BuildingWidget(),
      ),
    );
  }
}

class BuildingWidget extends StatefulWidget {
  const BuildingWidget({Key? key}) : super(key: key);

  @override
  State<BuildingWidget> createState() => _BuildingWidgetState();
}

class _BuildingWidgetState extends State<BuildingWidget> {
  var displayedElements = ['', '', '', '', '', '', '', '', '', ''];
  int xScore = 0;
  int yScore = 0;
  int winner = 0;
  bool xturn = false;
  int filledBoxed = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints.expand(width: 100, height: 100),
              child: Column(
                children: [
                  const Text(
                    'Player X',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$xScore',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints.expand(width: 100, height: 100),
              child: Column(
                children: [
                  const Text(
                    'Player O',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$yScore',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          constraints: const BoxConstraints.expand(width: 300, height: 300),
          child: GridView.builder(
              itemCount: displayedElements.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _assignValue(index);
                  },
                  child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          displayedElements[index],
                          style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                );
              }),
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _clearBoard,
              child: Container(
                constraints:
                    const BoxConstraints.expand(width: 150, height: 40),
                color: Colors.white,
                // padding: const EdgeInsets.all(1),
                child: const Center(
                  child: Text(
                    'Clear Score Board',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }

  void _assignValue(int index) {
    print('here inside this shit');
    if (xturn == false && displayedElements[index] == '') {
      setState(() {
        displayedElements[index] = 'X';
      });
      filledBoxed++;
    }
    if (!xturn == false && displayedElements[index] == '') {
      setState(() {
        setState(() {
          displayedElements[index] = 'O';
        });
        print("value of xturn here is $xturn");
      });
      filledBoxed++;
    }
    xturn = !xturn;
    _checkWinner();
  }

  void _clearBoard() {
    setState(() {});
    for (var i = 0; i < displayedElements.length; i++) {
      displayedElements[i] = '';
    }
    xScore = 0;
    yScore = 0;
    xturn = false;
  }

  _checkWinner() {
    if (displayedElements[0] == displayedElements[1] &&
        displayedElements[0] == displayedElements[2] &&
        displayedElements[2] != '') {
      showWinDialog(displayedElements[0]);
    }
    if (displayedElements[3] == displayedElements[4] &&
        displayedElements[3] == displayedElements[5] &&
        displayedElements[5] != '') {
      showWinDialog(displayedElements[3]);
    }
    if (displayedElements[6] == displayedElements[7] &&
        displayedElements[6] == displayedElements[8] &&
        displayedElements[6] != '') {
      showWinDialog(displayedElements[6]);
    }
    if (displayedElements[0] == displayedElements[3] &&
        displayedElements[0] == displayedElements[6] &&
        displayedElements[0] != '') {
      showWinDialog(displayedElements[0]);
    }
    if (displayedElements[1] == displayedElements[4] &&
        displayedElements[1] == displayedElements[7] &&
        displayedElements[1] != '') {
      showWinDialog(displayedElements[1]);
    }
    if (displayedElements[2] == displayedElements[5] &&
        displayedElements[2] == displayedElements[8] &&
        displayedElements[2] != '') {
      showWinDialog(displayedElements[2]);
    }
    //diagnol
    if (displayedElements[0] == displayedElements[5] &&
        displayedElements[0] == displayedElements[8] &&
        displayedElements[0] != '') {
      showWinDialog(displayedElements[0]);
    }
    if (displayedElements[2] == displayedElements[4] &&
        displayedElements[2] == displayedElements[6] &&
        displayedElements[2] != '') {
      showWinDialog(displayedElements[2]);
    } else if (filledBoxed == 9) {
      showDrawDialog();
    }
  }

  void showWinDialog(String winner) {
    showDialog(
        barrierDismissible:
            false, //if you outside of dialogue box it will not be dismessed
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Winner'),
            content: Text(winner),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _clearBoard();
                  },
                  child: const Text('Play Again'))
            ],
          );
        });

    if (winner == 'O') {
      xScore++;
    } else {
      yScore++;
    }
  }

  void showDrawDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Play Again'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _clearBoard();
                  },
                  child: const Text('Play Again'))
            ],
          );
        });
  }
}
