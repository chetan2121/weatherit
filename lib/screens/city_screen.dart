import 'package:flutter/material.dart';


class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 50.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),

                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, cityName);
              },
              child: Text(
                'Get Weather',

              ),
            ),
          ],
        ),
      ),
    );
  }
}