import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/image_entity.dart';
import 'package:flutter_app/pullrefresh/stagger_gv_pulldown.dart';
import 'package:flutter_app/pullrefresh/gv_pullup2.dart';
import 'package:flutter_app/pullrefresh/gv_pullup1.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'gv_pullup3.dart';

class PullrefreshPage extends StatefulWidget{

  @override
  State createState() {
    return new PullrefreshPageState();
  }
}


class PullrefreshPageState extends State<PullrefreshPage>{

  List<ImageBean> imageList = [];

  ScrollController _controller;

  int imageTotal = 0;

  int pageNum = 0;
  int pageCount = 50;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    _getImageList(pageNum, pageCount);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent){
        print(_controller.position.maxScrollExtent);
        if(imageList.length < imageTotal) {
          _getMoreData();
        } else {
          Fluttertoast.showToast(msg: "已加载完毕");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('下拉刷新'),
        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          showPop(),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return RefreshIndicator(
        child: GridView.builder(
            padding: EdgeInsets.only(top: 5),
            itemCount: imageList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.0,
            ),
            controller: _controller,
            itemBuilder: (BuildContext context, int index) {
              return getGridItemContainer(imageList[index]);
            }),
        onRefresh: _refresh);
  }

  Widget getGridItemContainer(ImageBean item) {
    try{
      return Stack(
        alignment: const Alignment(0.0, 0.9),
        //      alignment: Alignment.bottomCenter,
        children: <Widget>[
          new Image.network(
            item.thumb,
            width: (MediaQuery
                .of(context)
                .size
                .width - (2.0 * 2)) / 3,
            height: (MediaQuery
                .of(context)
                .size
                .width - (2.0 * 2)) / 3,
            fit: BoxFit.cover,
          ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }catch(e){
      return Stack();
    }
  }

  Future<void> _refresh() async{
    imageList.clear();
    pageNum = 0;
    _getImageList(pageNum, pageCount);
    return null;
  }

  Future<void> _getMoreData() async{
    pageNum ++;
    _getImageList(pageNum, pageCount);
    return null;
  }

  void _getImageList(int sn, int pn) async {
    var url = 'http://image.so.com/j?q=海南&sn='+sn.toString()+'&pn='+pn.toString();
    print(url);
    Dio dio = new Dio();
    print("_getImageList");
    List<ImageBean> result;
    try {
      var response = await dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var jsona = response.data.toString();
        Map<String, dynamic> data = json.decode(jsona);
        ImageResponse imageResponse = ImageResponse.fromJson(data);

        imageTotal = imageResponse.total;
        print('total is ${imageResponse.total}');

        result = imageResponse.list;

      }else{
        print("Http status ${response.statusCode}");
      }
    } catch (exception) {
    }

    setState(() {
      imageList.addAll(result);
//      print("imageList is "+imageList.toString());
    });

  }


  Widget showPop(){
    return PopupMenuButton(
      offset: Offset(0, 60),
      initialValue: "",
      padding: EdgeInsets.all(0.0),
      itemBuilder: (BuildContext context){
        return <PopupMenuItem<String>>[
          PopupMenuItem(child: Text("pulldownstagg"),value: "pulldown",),
          PopupMenuItem(child: Container(height: 1,color: Colors.grey,padding: EdgeInsets.all(0.0),margin: EdgeInsets.all(0.0),), height: 1,),
          PopupMenuItem(child: Text("PullUpGridPage1"),value: "pullupgrid1",),
          PopupMenuItem(child: Container(height: 1,color: Colors.grey,padding: EdgeInsets.all(0.0),margin: EdgeInsets.all(0.0),), height: 1,),
          PopupMenuItem(child: Text("PullUpGridPage2"),value: "pullupgrid2",),
          PopupMenuItem(child: Container(height: 1,color: Colors.grey,padding: EdgeInsets.all(0.0),margin: EdgeInsets.all(0.0),), height: 1,),
          PopupMenuItem(child: Text("PullUpGridPage3"),value: "pullupgrid3",),
        ];
      },
      onSelected: (String value){
        switch(value){
          case "pulldown":
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new PullDownPage(),
              ),
            );
            break;
          case "pullupgrid1":
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new PullUpPage(),
              ),
            );
            break;
          case "pullupgrid2":
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new PullUpGridPage(),
              ),
            );
            break;
          case "pullupgrid3":
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new PullUpGridPage1(),
              ),
            );
            break;
        }
      },
      icon: Icon(Icons.list),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}