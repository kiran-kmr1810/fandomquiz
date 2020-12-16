import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizstar/quizpage.dart';

class Homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<Homepage> {

  List<String> images = [
    "images/brba.jpg",
    "images/got.jpg",
    "images/100.jpg",
    "images/st.jpg",
    "images/boys.jpg",
    "images/rdale.jpg",
    "images/witcher.jpg",
    "images/sexed.jpg",
    "images/you.jpg",
    "images/13ry.jpg",
    "images/umberella.jpg",
  ];

  List<String> des = [
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
    "How well do you know THE BOYS",
  ];

  Widget customcard(String langname, String image, String des){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(langname),
          ));
        },
        child: Material(
          color: Colors.black,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Alike"
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Fandom series Quiz",
          style: TextStyle(
            fontFamily: "Satisfy",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard("breaking bad", images[0], des[0]),
          customcard("game of thrones", images[1], des[1]),
          customcard("the 100", images[2], des[2]),
          customcard("stranger things", images[3], des[3]),
          customcard("the boys", images[4], des[4]),
          customcard("riverdale", images[5], des[5]),
          customcard("the witcher", images[6], des[6]),
          customcard("sex education", images[7], des[7]),
          customcard("you", images[8], des[8]),
          customcard("13 reasons why", images[9], des[9]),
          customcard("the umberella academy", images[10], des[10]),
        ],
      ),
    );
  }
}