import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../custom/custom_route.dart';
import '../detail.dart';

final List<String> imageList = [
  'images/meinv-1.jpg',
  'images/meinv-2.jpg',
  'images/meinv-3.jpg',
  'images/shanshui-4.jpg',
  'images/shanshui-5.jpg',
];

final List<String> descriptions = [
  '社会我宝姐，人美路子野',
  '社会我宝姐，人美路子野',
  '社会我宝姐，人美路子野',
  '莲，出淤泥而不染',
  '周五快到了，准备追更新',
];

class BannerTINDERPage extends StatefulWidget {
  @override
  State createState() {
    return new BannerTINDERPageState();
  }
}

class BannerTINDERPageState extends State<BannerTINDERPage>
    with SingleTickerProviderStateMixin {
  int num = 0;
  SwiperController swiperController;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    print('build');
    return new Scaffold(
      appBar: new AppBar(
        title: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
          child: new Text('BannerTINDERShow'),
        ),
//        title: new Text('BannerTINDERShow'),
      ),
      body: _buildContainer(),
    );
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    swiperController = new SwiperController();
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500),
    );
    _buildAnimation();
  }

  Widget _buildContainer() {
    return new Column(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          height: 180.0,
//          margin: const EdgeInsets.only(bottom: 10.0),
          child: _buildSwiper(),
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

  Widget _buildSwiper() {
    return new SizedBox.fromSize(
      size: Size.fromHeight(280.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
            child: GestureDetector(
              onTapDown: (TapDownDetails d) {
                setState(() {
                  swiperController.stopAutoplay();
                });
              },
              onTapUp: (TapUpDetails s) {
                setState(() {
                  Fluttertoast.showToast(msg: descriptions[index]);
                  controller.forward();
                  num = index;
                });
              },
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: Tween(begin: 1.0, end: 1.23).animate(CurvedAnimation(
                    parent: controller, curve: Curves.fastOutSlowIn)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(imageList[index], fit: BoxFit.cover),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: imageList.length,
        itemWidth: 350.0,
        itemHeight: 250.0,
        //高度必须设置
        layout: SwiperLayout.TINDER,
        //选中时的指示器
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.black38,
            activeColor: Colors.white,
          ),
          margin: const EdgeInsets.only(bottom: 22.0),
        ),
        controller: swiperController,
        control: null,
        duration: 300,
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8,
        scale: 0.85,
        autoplay: true,
//        onTap: (int index) {
//          Fluttertoast.showToast(msg: '点击了第$index个');
//          swiperController.stopAutoplay();
//          Fluttertoast.showToast(msg: descriptions[index]);
//          controller.forward();
//        },
      ),
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

  void _buildAnimation() {
    controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          print('completed');
//          controller.reset();
//          controller.reverse();
//          swiperController.startAutoplay();
          Navigator.of(context)
              .push(
            CustomRoute(
              new DetailPage(
                image: imageList[num],
              ),
            ),
          )
              .then(
                (value) => controller.reverse(),
          );
//          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("$result")));
          break;
        case AnimationStatus.dismissed:
          print('dismissed');
          swiperController.startAutoplay();
//          controller.reset();
//          Navigator.of(context).push(
//            CustomRoute(
//              new DetailPage(
//                image: imageList[num],
//              ),
//            ),
//          );
          break;
        case AnimationStatus.forward:
//          controller.forward();
          print('forward');
          break;
        case AnimationStatus.reverse:
//          controller.reverse();
          print('reverse');
          break;
      }
    });
  }

  @override
  void dispose() {
    imageList.clear();
    descriptions.clear();
    controller.dispose();
    swiperController.dispose();
    super.dispose();
  }
}