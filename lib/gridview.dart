import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gridview.g.dart';

class GridViewPage extends StatefulWidget {
  @override
  State createState() {
    return new GridViewPageState();
  }
}


class GridViewPageState extends State<GridViewPage> {
  final _textControl = TextEditingController(
    text: "北京",
  );

  final _focusNode = new FocusNode();

  List<ImageBean> imageList = [];

  @override
  void initState() {
    super.initState();
    print(imageList.length);
    _getImageList('北京', '0', '50');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TextField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            hintText: "请输入地址",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
          ),
          onChanged: (value) {},
          controller: _textControl,
          focusNode: _focusNode,
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _listPressed)
        ],
      ),
      body: GridView.builder(
          itemCount: imageList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return getItemContainer(imageList[index]);
          }),
    );
  }

  void _listPressed() {
    _getImageList(_textControl.text, '0', '50');
  }

  Widget getItemContainer(ImageBean item) {
    try{
      return Stack(
        alignment: const Alignment(0.0, 0.9),
        //      alignment: Alignment.bottomCenter,
        children: <Widget>[
          //        Image.asset(
          //          'images/meinv-1.jpg',
          //          width: (MediaQuery.of(context).size.width - (2.0 * 2)) / 3,
          //          height: (MediaQuery.of(context).size.width - (2.0 * 2)) / 3,
          //          fit: BoxFit.cover,
          //        ),
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
          ),
        ],
      );
    }catch(e){
      return Stack();
    }
  }

  _getImageList(String q, String sn, String pn) async {
    var url = 'http://image.so.com/j?q='+q+'&sn='+sn+'&pn='+pn;
    var httpClient = new HttpClient();
    print("_getImageList");
    List<ImageBean> result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
//      print("response is "+ String.fromCharCode(response.statusCode));

      if (response.statusCode == HttpStatus.ok) {
        print("response is "+ response.statusCode.toString());
//        response.redirect(response.headers.value("location"))
        var jsona = await response.transform(utf8.decoder).join();
        print("json is "+jsona);

//        ImageResponse imageResponse = jsonDecode(json, ImageResponse.class);
        Map<String, dynamic> data = json.decode(jsona);
//        print(data);
        ImageResponse imageResponse = ImageResponse.fromJson(data);

        print('total is '+imageResponse.total.toString());

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

}
@JsonSerializable()
class ImageBean extends Object {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'thumb')
  String thumb;
  @JsonKey(name: 'width')
  String width;
  @JsonKey(name: 'height')
  String height;


  ImageBean(this.title, this.thumb, this.width, this.height);

  factory ImageBean.fromJson(Map<String, dynamic> json) => _$ImageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBeanToJson(this);

}
@JsonSerializable()
class ImageResponse extends Object {
  int total;
  List<ImageBean> list;


  ImageResponse(this.total, this.list);

  factory ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);


}
