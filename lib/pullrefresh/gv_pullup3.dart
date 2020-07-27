import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/image_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PullUpGridPage1 extends StatefulWidget{

  @override
  State createState() {
    return PullUpGridPage1State();
  }
}

class PullUpGridPage1State extends State<PullUpGridPage1> {

  List<ImageBean> imageList = [];

  ScrollController _controller;
  bool isVisible = true;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("上拉动画"),
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    print("imageList.length is ${imageList.length}");
    return creatContainer();
  }

  /**
   * 这种布局的好处是能在头部也加一个布局，就是在gridview之前加上一个图片或者其他的布局
   */
  Widget creatContainer(){
    return RefreshIndicator(
      child: Scrollbar(
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: <Widget>[
                createGridview(imageList.length),
                _loadingView(),
              ],
            ),
          ),
      ),
      onRefresh: _refresh,
    );
  }

  Widget createGridview(int count){
    return GridView.builder(
        padding: EdgeInsets.only(top: 5),
        itemCount:count,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.0,
        ),
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
   * 说明一下，这里CircularProgressIndicator有些大，简单的布局不能缩小，有的时候反而会变形，因此增加了几重
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
    var url = 'http://image.so.com/j?q=西藏&sn='+sn.toString()+'&pn='+pn.toString();
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
      if(imageList.length >= imageTotal)
        isVisible = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}