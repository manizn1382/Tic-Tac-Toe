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

  late List<String> Board;
  late int Opoint,Xpoint;
  @override
  void initState() {
    super.initState();
    InitializeBoard();
    Opoint=0;
    Xpoint=0;
  }

  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       backgroundColor: Colors.black,
        body: Column(
          children: [
            ScoreBoard(),
              //...
          ]
        ),
   ),
    );


  void InitializeBoard() {
    setState(() =>
      Board=["","","","","","","","",""],
    );
  }
  Widget ScoreBoard(){
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player X",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                  ),
                  Text(Xpoint.toString(),style: TextStyle(fontSize: 20,color: Colors.amberAccent))
                ],
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height/3,width: MediaQuery.of(context).size.width/3,),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player O",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurple),
                  ),
                  Text(Opoint.toString(),style: TextStyle(fontSize: 20,color: Colors.amberAccent))
                ],
              ),
            )
          ],
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




