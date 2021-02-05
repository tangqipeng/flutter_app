import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyText extends StatefulWidget{

  @override
  State createState() {
    return new MyTextState();
  }
}

class MyTextState extends State<MyText>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Text Show'),
      ),
      body: new SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: _getBody(),
      ),
    );
  }

  Widget _getBody(){
    return Column(
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Text('标准的'),
            new Text(
              '居中的',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.red,
                backgroundColor: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("距上10"),
            ),
            SizedBox.fromSize(
              size: Size(50, 50),
              child: Text(
                '盒子',
                style: TextStyle(
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
                textAlign: TextAlign.center,//效果明显
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
        new Column(
          children: <Widget>[
            new Text('标准的'),
            new Text(
              '居中的',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.red,
                backgroundColor: Colors.green,
              ),
            ),
//        Center(
//          child: Text('居中的'),
//        ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("距上10"),
            ),
            SizedBox.fromSize(
              size: Size(200, 50),
              child: Text(
                '盒子',
                style: TextStyle(
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
        new Column(
          children: <Widget>[
            new Text('标准的'),
            new Text(
              '居中的',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.red,
                backgroundColor: Colors.green,
              ),
            ),
            Center(
              child: Text('居中的'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("距上10"),
            ),
            SizedBox.fromSize(
              size: Size(50, 50),
              child: Text(
                '盒子',
                style: TextStyle(
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            new Text(
                "asdasdasdasdasdasdasdfsdfassdfsnasbdkasdfjhgfjkhqwvefjhwqkejhfvwjfvqe",
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: new Text(
                'asdasdasdasdasdasdasdfsdfassdfsnasbdkasdfjhgfjkhqwvefjhwqkejhfvwjfvqe',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: new Text(
                'asdasdasdasdasdasdasdfsdfassdfsnasbdkasdfjhgfjkhqwvefjhwqkejhfvwjfvqe',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: new Text(
                'asdasdasdasdasdasdasdfsdfassdfsnasbdkasdasdasdasdasdasdasdasdfsdfassdfsnasbdkasdfjhgfjkhqwvefjhwqkejhfvwjfvqefjhgfjkhqwvefjhwqkejhfvwjfvqe',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text.rich(
                new TextSpan(
                  text: "拼接文字",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  children: <TextSpan> [
                    new TextSpan(
                      text: '拼接文字2',
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                    new TextSpan(
                      text: '拼接文字3',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: shimmerText(),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: shimmerText1(),
            ),
          ],
        ),
      ],
    );
  }

  Widget shimmerText(){
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Text(
          "SHIMMERTEXT",
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
    );
  }

  Widget shimmerText1(){
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        child: Text(
          "SHIMMERTEXT1",
          style: TextStyle(
              fontSize: 20
          ),
        ),
      ),
    );
  }
}

