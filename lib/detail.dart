import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String image;

  DetailPage({this.image});

  @override
  State createState() {
    return new DetailPageState(image: image);
  }
}

class DetailPageState extends State<DetailPage> {
  String image;

  DetailPageState({this.image});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Details'),
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return new ListView(
      children: <Widget>[
        Image.asset(
          this.image,
          height: 180.0,
          fit: BoxFit.cover,
        ),
        new Container(
          padding: new EdgeInsets.only(
              left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        'Oeschinen Lake Campground',
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Text(
                      "Kandersteg, Switzerland",
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              new Icon(
                Icons.star,
                color: Colors.red[500],
              ),
              new Text(
                '43',
              ),
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(top: 25.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButtonColumn(Icons.call, 'CALL'),
              _buildButtonColumn(Icons.near_me, 'ROUTE'),
              _buildButtonColumn(Icons.share, 'share')
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Text(
            '''Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.''',
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Column _buildButtonColumn(IconData icon, String label) {
    Color color = Colors.blue;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
