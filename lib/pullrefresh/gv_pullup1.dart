import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/image_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PullUpPage extends StatefulWidget{

  @override
  State createState() {
    return PullUpPageState();
  }
}

/**
 * 这种模式加在gridview后，大小都不好处理，只能让他在下一行的中间那个位置，如果是偶数个就更不好处理了，因此再写另一种
 * 这种模式主要是在Listview中好处理，但在gridview中有些麻烦
 * 虽然处理的不好，但是还是留下来
 */
class PullUpPageState extends State<PullUpPage> {

  List<ImageBean> imageList = [];

  ScrollController _controller;
  int mode = 0;

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

  int getItemCount(){
    int count = imageList.length;
    if(imageList.length < imageTotal){
      if (imageList.length % 3 == 0){
        count = imageList.length+2;
      } else if (imageList.length % 3 == 1){
        count = imageList.length+4;
      } else if (imageList.length % 3 == 2){
        count = imageList.length+3;
      }
    }
    return count;
  }

  Widget getBody(){
    int itemCount = getItemCount();
    print("imageList.length is ${imageList.length}");
    print("count is ${itemCount}");
    return RefreshIndicator(
        child: createGridview(itemCount),
        onRefresh: _refresh,
    );
  }

  Widget createGridview(int count){
    if (mode == 0){
      return GridView.builder(
          padding: EdgeInsets.only(top: 5),
          itemCount:count,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1.0,
          ),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return loadingGridview(count, index);
          });
    }
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

  Widget _loadingView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Center(
        child: Row(
          children: <Widget>[
            Visibility(
              visible: true,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
            Text('正在加载...',),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
    var url = 'http://image.so.com/j?q=厦门&sn='+sn.toString()+'&pn='+pn.toString();
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

  Widget loadingGridview(int count, int index){
    if (index < imageList.length){
      return getGridItemContainer(imageList[index]);
    } else if(index >= imageList.length && index < count -1){
      return Container();
    } else {
      return _loadingView();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}