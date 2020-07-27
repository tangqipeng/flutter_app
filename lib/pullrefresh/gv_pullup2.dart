import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/image_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PullUpGridPage extends StatefulWidget{

  @override
  State createState() {
    return PullUpGridPageState();
  }
}

/**
 * 加载更多的loading一上一下可能也不符合你想要的效果，没事，咱们继续向后看
 */
class PullUpGridPageState extends State<PullUpGridPage> {

  List<ImageBean> imageList = [];

  ScrollController _controller;
  bool isVisible = false;

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
          setState(() {
            isVisible = true;
          });
          _getMoreData();
        } else {
          setState(() {
            isVisible = false;
          });
          Fluttertoast.showToast(msg: "已加载完毕");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("上拉动画"),
      ),
      body: getBody(),
      bottomSheet: _loadingView(),
    );
  }

  Widget getBody(){
    print("imageList.length is ${imageList.length}");
    return RefreshIndicator(
      child: createGridview(imageList.length),
      onRefresh: _refresh,
    );
  }

  Widget createGridview(int count){
    return GridView.builder(
        padding: EdgeInsets.only(top: 5, bottom: 50),
        itemCount:count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.0,
        ),
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return getGridItemContainer(imageList[index]);
        });
  }

  Widget getGridItemContainer(ImageBean item) {
    try{
      return Stack(
        alignment: const Alignment(0.0, 0.9),
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

  /**
   * 说明一下，这里CircularProgressIndicator有些大，简单的布局不能见小它，因此增加了几重
   */
  Widget _loadingView() {
    return Visibility(
      visible: isVisible,
      child: Container(
        width: MediaQuery.of(context).size.width,
//        color: Colors.black12,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text('正在加载...'),
            ),
          ],
        ),
      ),
    );
//    return Container(
//      width: MediaQuery.of(context).size.width,
//      height: 50,
//      child: Row(
//        children: <Widget>[
//          Visibility(
//            visible: true,
//            child: CircularProgressIndicator(
//              strokeWidth: 2.0,
//            ),
//          ),
//          Text(
//            '正在加载...',
//          ),
//        ],
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//      ),
//    );
  }

  Future<void> _refresh() async{
    imageList.clear();
    pageNum = 0;
    _getImageList(pageNum, pageCount);
    return null;
  }

  Future<void> _getMoreData() async{
    pageNum ++;
//    Future.delayed(Duration(seconds: 2), () {
//      _getImageList(pageNum, pageCount);
//    });
    _getImageList(pageNum, pageCount);
    return null;
  }

  void _getImageList(int sn, int pn) async {
    var url = 'http://image.so.com/j?q=武汉&sn='+sn.toString()+'&pn='+pn.toString();
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
      isVisible = false;
      imageList.addAll(result);
//      print("imageList is "+imageList.toString());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}