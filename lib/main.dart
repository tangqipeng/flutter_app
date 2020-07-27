import 'package:flutter/material.dart';
import 'package:flutter_app/banner/banner.dart';
import 'package:flutter_app/gridview/gridview.dart';
import 'package:flutter_app/pullrefresh/gv_pulldown.dart';
import 'package:flutter_app/listview/random.dart';
import 'package:flutter_app/tab/tabhome.dart';
import 'package:flutter_app/banner/test.dart';
import 'package:flutter_app/text/text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '各种控件效果',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget{
  
  @override
  State createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>{

  List stringList = ['Text', '轮播图', 'ListView', 'GridView', '底部导航栏', '下拉刷新'];
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('控件展示'),
      ),
      body: new StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(10.0),
          crossAxisCount: 4,
          itemCount: stringList.length,
          itemBuilder: (context, i){
            return _itemWidget(i);
          },
//          staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
          staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index == 0 ? 2.5 : 3),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
      ),
    );
  }

  Widget _itemWidget(int index){
    String title = stringList[index];
    return new Material(
      elevation: 5.0,
      color: Colors.red,
      borderRadius: new BorderRadius.all(
        new Radius.circular(10.0),
      ),
      child: new InkWell(
        onTap: (){
          if(title == 'Text') {
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new MyText(),
              ),
            );
          } else if(title == '轮播图'){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new TestPage(title: 'Banner'),
              ),
            );
          } else if(title == 'ListView'){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new RandomWords(),
              ),
            );
          } else if(title == 'GridView'){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new GridViewPage(),
              ),
            );
          } else if(title == '底部导航栏'){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new HomePage(),
              ),
            );
          } else if(title == '下拉刷新'){
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => new PullrefreshPage(),
              ),
            );
          }
        },
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
              inherit: true,
          //              backgroundColor: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.amber,
              fontStyle: FontStyle.italic,
              height: 1,
              shadows: [BoxShadow(color: Colors.grey, offset: Offset(-1, -1), blurRadius: 5)],
            ),
          ),
        ),
      ),
    );
  }
}