
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizstar/resultpage.dart';
import 'resultpage.dart';

class getjson extends StatelessWidget {
  String langname;
  getjson(this.langname);
  String assettoload;

  setasset() {
    if (langname == "breaking bad") {
      assettoload = "assets/DBMS.json";
    }else if (langname == "game of thrones") {
      assettoload = "assets/GOT.json";
    }else if (langname == "the 100") {
      assettoload = "assets/100.json";
    }else if (langname == "stranger things") {
      assettoload = "assets/ST.json";
    }else if (langname == "the boys") {
      assettoload = "assets/boys.json";
    }else if (langname == "riverdale") {
      assettoload = "assets/rdale.json";
    }else if (langname == "the witcher") {
      assettoload = "assets/witcher.json";
    }else if (langname == "sex education") {
      assettoload = "assets/sexed.json";
    }else if (langname == "you") {
      assettoload = "assets/you.json";
    }else if (langname == "13 reasons why") {
      assettoload = "assets/13ry.json";
    }else {
      assettoload = "assets/umberella.json";
    }
  }

  @override
  Widget build(BuildContext context) {

    setasset();

    return FutureBuilder(
      future:DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "No test right now",
              ),
            ),
          );
        } else {
          return Quizpage(mydata: mydata);
        }
      },
    );
  }
}

class Quizpage extends StatefulWidget {

  var mydata;

  Quizpage({Key key, @required this.mydata}) : super(key: key);

  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<Quizpage> {

  var mydata;
  _quizpageState(this.mydata);

  Color colortoshow = Colors.white;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  int timer = 30;
  String showtimer = '30';

  Map<String, Color> btncolor = {
    "a" : Colors.white,
    "b" : Colors.white,
    "c" : Colors.white,
    "d" : Colors.white,
  };

  bool canceltimer = false;

  @override
  void initState(){
    starttimer();
    super.initState();
  }



  void starttimer() async{
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer < 1){
          t.cancel();
          nextquestion();
        }else if(canceltimer == true){
          t.cancel();
        }
        else{
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion(){
    canceltimer = false;
    timer = 30;
    setState(() {
      if(i < 15){
        i++;
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks : marks),
        ));
      }
      btncolor['a'] = Colors.white;
      btncolor['b'] = Colors.white;
      btncolor['c'] = Colors.white;
      btncolor['d'] = Colors.white;
    });
    starttimer();
  }

  void checkanswer(String k){
    if(mydata[2][i.toString()] == mydata[1][i.toString()][k]){
      marks++;
      colortoshow = right;
    }
    else{
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    Timer(Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Alike',
            fontSize: 16.0,
          ),
          maxLines: 2,
        ),
        color: btncolor[k],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        splashColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "fandom series Quiz"
            ),
            content: Text(
              "You can't go out now."
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok'
                ),
              )
            ],
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            color: Colors.transparent,

            //background image

            image: DecorationImage(image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomLeft,

                  //QUESTION TEXT

                  child: Text(
                    mydata[0][i.toString()],
                    style: TextStyle(fontSize: 20.0, fontFamily: "StarR", color: Colors.black ,backgroundColor: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      showtimer,
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times New Roman',
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
