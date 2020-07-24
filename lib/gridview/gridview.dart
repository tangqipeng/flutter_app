import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../entity/image_entity.dart';

class GridViewPage extends StatefulWidget {
  @override
  State createState() {
    return new GridViewPageState();
  }
}


class GridViewPageState extends State<GridViewPage> with WidgetsBindingObserver{
  final _textControl = TextEditingController(
    text: "北京",
  );

  final FocusNode _focusNode = new FocusNode();

  List<ImageBean> imageList = [];

  int mode = 0;

  double itemWidth = 20;

  bool isGone = true;

  @override
  void initState() {
//    WidgetsBinding.instance.addObserver(this);
    _getImageList(_textControl.text, '0', '50');
    if(_textControl.text != null){
      isGone = false;
    } else {
      isGone = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemWidth = ((MediaQuery.of(context).size.width - 2.0) / 2);
    return new Scaffold(
      appBar: new AppBar(
        titleSpacing: 1,
        title: Stack(
          alignment: const Alignment(1.0, 0.0),
          children: <Widget>[
            new Container(
//              color: Colors.black12,
              child: new TextField(
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "请输入地址",
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  labelStyle: TextStyle(
                    backgroundColor: Colors.grey,
                  ),
//                  border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(30),
//                      borderSide: BorderSide.none,
//                  ),
                ),
                onChanged: (value) {
                  print(value);
                  if(value != null && value.length > 0){
                    isGone = false;
                  }else{
                    isGone = true;
                  }
                  setState(() {

                  });
                },
                controller: _textControl,
                focusNode: _focusNode,
              ),
            ),
            new Offstage(
              offstage: isGone,
              child: new IconButton(
                icon: Icon(Icons.clear),
                onPressed: _pressClear,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          new Padding(
            padding: EdgeInsets.all(10),
            child: new RaisedButton(
              onPressed: _confirmPressed,
              child: new Text('确定'),
            ),
          ),
          new IconButton(icon: new Icon(Icons.list), onPressed: _listPressed),
        ],
      ),
      body: _getBodyCntainer()
    );
  }

  void _pressClear(){
    _textControl.clear();
    isGone = true;
    setState(() {

    });
  }

  void _confirmPressed() {
    imageList.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    _getImageList(_textControl.text, '0', '50');
  }

  void _listPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          title: Center(
            child: Text(
              '模式切换',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          titlePadding: EdgeInsets.all(10),
          elevation: 5,
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          children: <Widget>[
            Container(
              height: 1,
              color: Colors.black38,
            ),
            ListTile(
              title: Center(child: Text('GridView'),),
              onTap: (){
                if(mode == 1 && _textControl.text != null && _textControl.text.length > 0){
                  imageList.clear();
                  mode = 0;
                  _getImageList(_textControl.text, '0', '50');
                }else {
                  Fluttertoast.showToast(msg: (_textControl.text != null && _textControl.text.length > 0) ? "目前已是Gridview模式":"TextField没有内容");
                }
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1,
              color: Colors.black38,
            ),
            ListTile(
              title: Center(child: Text('瀑布流'),),
              onTap: (){
                if(mode == 0 && _textControl.text != null && _textControl.text.length > 0){
                  imageList.clear();
                  mode = 1;
                  _getImageList(_textControl.text, '0', '50');
                } else {
                  Fluttertoast.showToast(msg: (_textControl.text != null && _textControl.text.length > 0) ? "目前已是瀑布流模式":"TextField没有内容");
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  Widget _getBodyCntainer(){
    if(mode == 0){
      return GridView.builder(
          padding: EdgeInsets.only(top: 5),
          itemCount: imageList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return getGridItemContainer(imageList[index]);
          });
    }else{
      return StaggeredGridView.builder(
          padding: EdgeInsets.only(top: 5),
          itemCount: imageList.length,
          gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),),
          itemBuilder: (BuildContext context, int index){
          return getStaggGridItemContainer(imageList[index]);
        },
      );
    }
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

  Widget getStaggGridItemContainer(ImageBean item) {
    try{
      double hight = double.parse(item.height);
      double width = double.parse(item.width);
      return Stack(
        alignment: const Alignment(0.0, 0.9),
        //      alignment: Alignment.bottomCenter,
        children: <Widget>[
          new Image.network(
            item.thumb,
            width: itemWidth,
            height: (itemWidth * hight / width),
            fit: BoxFit.fill,
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

  void _getImageList(String q, String sn, String pn) async {
    var url = 'http://image.so.com/j?q='+q+'&sn='+sn+'&pn='+pn;
    var httpClient = new HttpClient();
    print("_getImageList");
    List<ImageBean> result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        print("response is ${response.statusCode}");
        var jsona = await response.transform(utf8.decoder).join();
        print("json is ${jsona}");

        Map<String, dynamic> data = json.decode(jsona);
        ImageResponse imageResponse = ImageResponse.fromJson(data);

        print('total is ${imageResponse.total}');

        result = imageResponse.list;

      }else{
        print("Http status ${response.statusCode}");
      }
    } catch (exception) {
    }

    setState(() {
      imageList = result;
//      print("imageList is "+imageList.toString());
    });
  }

//  @override
//  void didChangeMetrics() {
//    super.didChangeMetrics();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      setState(() {
//        if(MediaQuery.of(context).viewInsets.bottom > 0){
//          Fluttertoast.showToast(msg: "键盘弹出");
//        }else{
//          Fluttertoast.showToast(msg: "键盘隐藏");
//        }
//      });
//    });
//  }

  @override
  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
