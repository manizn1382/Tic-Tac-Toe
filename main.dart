import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late List<String> Board=List.filled(9, '');
  late int Opoint,Xpoint;
  bool Xturn=true;
  int filledBoxes = 0;
  @override
  void initState() {
    super.initState();
    InitializeBoard();
    Opoint=0;
    Xpoint=0;
  }


  void _BoxTapHandeler(int index) {
    setState(() {
      if (Xturn && Board[index] == '') {
        Board[index] = 'X';
        filledBoxes++;
        //_checkForWinner();
      } else if (!Xturn && Board[index] == '') {
        Board[index] = 'O';
        filledBoxes++;
        //_checkForWinner();
      }

      Xturn = !Xturn;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _checkForWinner();
      });
    });
  }

  void _checkForWinner() {

    // Checking rows
    if (Board[0] == Board[1] &&
        Board[0] == Board[2] &&
        Board[0] != '') {
      _showWinDialog(Board[0]);
    }
    if (Board[3] == Board[4] &&
        Board[3] == Board[5] &&
        Board[3] != '') {
      _showWinDialog(Board[3]);
    }
    if (Board[6] == Board[7] &&
        Board[6] == Board[8] &&
        Board[6] != '') {
      _showWinDialog(Board[6]);
    }

    // Checking Column
    if (Board[0] == Board[3] &&
        Board[0] == Board[6] &&
        Board[0] != '') {
      _showWinDialog(Board[0]);
    }
    if (Board[1] == Board[4] &&
        Board[1] == Board[7] &&
        Board[1] != '') {
      _showWinDialog(Board[1]);
    }
    if (Board[2] == Board[5] &&
        Board[2] == Board[8] &&
        Board[2] != '') {
      _showWinDialog(Board[2]);
    }

    // Checking Diagonal
    if (Board[0] == Board[4] &&
        Board[0] == Board[8] &&
        Board[0] != '') {
      _showWinDialog(Board[0]);
    }

    if (Board[2] == Board[4] &&
        Board[2] == Board[6] &&
        Board[2] != '') {
      _showWinDialog(Board[2]);
    }
    else if (filledBoxes == 9) {
        _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Player $winner is the winner!"),
      ),
    );

    if (winner == 'O') {
      Opoint++;
    } else if (winner == 'X') {
      Xpoint++;
    }
    return;
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              ElevatedButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }






  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        Board[i] = '';
      }
    });

    filledBoxes = 0;
  }


  void _clearScoreBoard() {
    setState(() {
      Xpoint = 0;
      Opoint = 0;
      for (int i = 0; i < 9; i++) {
        Board[i] = '';
      }
    });
    filledBoxes = 0;
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
             ScoreBoard(),
             GameBoard(),
            RestartButtons()

          ],
        ),
      ),
    );
  }



  void InitializeBoard() {
    setState(() =>
      Board=["","","","","","","","",""],
    );
  }

  Widget RestartButtons(){
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(onPressed: _clearBoard, child:  Text("clear Board"),style: FilledButton.styleFrom(foregroundColor: Colors.black,backgroundColor: Colors.amberAccent),),
          SizedBox(width: 30),
          FilledButton(onPressed: _clearScoreBoard, child: Text("clear Score Board"),style: FilledButton.styleFrom(foregroundColor: Colors.black,backgroundColor: Colors.amberAccent),),
          SizedBox(width: 30),
          FilledButton(onPressed: _clearScoreBoard, child: Text("Restart"),style: FilledButton.styleFrom(foregroundColor: Colors.black,backgroundColor: Colors.amberAccent),)
        ],
      ),
    );
  }



  Widget GameBoard(){
    return Padding(
      padding: EdgeInsets.all(100),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.height / 3,
        child: GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 3),
          itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  _BoxTapHandeler(index);
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple,

                  ),
                  child: Center(
                    child: Text(
                      Board[index],
                      style: TextStyle(fontSize: 10,color: Colors.black),
                    ),
                  ),
              ),
              );
          },
        itemCount: 9,
        ),

      ),
    );





}


  Widget ScoreBoard() {
    return Expanded(
      child: Row(
        // creating the ScoreBoard
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/44),
                  Text(
                    'Player X',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(
                    Xpoint.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/44),
                  Text(
                    'Player O',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(
                    Opoint.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
class Player extends StatelessWidget{

  static const Player1="X";
  static const Player2="O";
  static const defaultMode="";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}




