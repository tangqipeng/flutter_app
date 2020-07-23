import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'banner.dart';

class TestPage extends StatefulWidget {
  final String title;

  TestPage({this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TestPageState(title: title);
  }
}

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

class TestPageState extends State<TestPage> {
  final String title;

  SwiperController swiperController = new SwiperController();

  TestPageState({this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    void _onPointerDown(PointerDownEvent event) {
      print("_onPointerDown：" + event.toString());
      swiperController.stopAutoplay();
      Fluttertoast.showToast(msg: "stopAutoplay");
    }

    void _onPointerMove(PointerMoveEvent event) {
      print("_onPointerMove：" + event.toString());
      Fluttertoast.showToast(msg: "_onPointerMove");
    }

    void _onPointerUp(PointerUpEvent event) {
      print("_onPointerUp：" + event.toString());
      Fluttertoast.showToast(msg: "startAutoplay");
      swiperController.startAutoplay();
    }

    return new Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: _buildSwiper(),
        ),
        Center(
          child: new SizedBox.fromSize(
            size: new Size.fromHeight(180.0),
            child: new Swiper(
              itemBuilder: (context, i) {
                return new Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
                  child: Listener(
                    onPointerDown: _onPointerDown,
                    onPointerMove: _onPointerMove,
                    onPointerUp: _onPointerUp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(
                            imageList[i],
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: imageList.length,
              itemWidth: 300.0,
              layout: SwiperLayout.STACK,
              pagination: new SwiperPagination(
                builder: new DotSwiperPaginationBuilder(
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
              onTap: (int i) {
                Fluttertoast.showToast(msg: descriptions[i]);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) => new BannerPage(),
                  ),
                );
              },
            ),
          ),
        ),
        Center(
          child: new SizedBox.fromSize(
            size: Size.fromHeight(180.0),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: descriptions[index]);
                    },
                    child: ClipRRect(
//                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(6.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(imageList[index], fit: BoxFit.cover),
//                      decorationBox,
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: imageList.length,
              //选中时的指示器
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black38,
                    activeColor: Colors.white,
                  ),
                  margin: const EdgeInsets.only(bottom: 22.0)),
              control: null,
              duration: 300,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.95,
              autoplay: true,
              onTap: (int index) {
                Fluttertoast.showToast(msg: '点击了第$index个');
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwiper() {
    return new Swiper(
      itemBuilder: (context, i) {
        return _buildItemImage(i);
      },
      itemCount: imageList.length,
      pagination: new SwiperPagination(
          builder: new DotSwiperPaginationBuilder(
            color: Colors.black38,
            activeColor: Colors.blueAccent,
          )),
      control: null,
      duration: 300,
      scrollDirection: Axis.horizontal,
      autoplay: true,
      onTap: (int i) {
        Fluttertoast.showToast(msg: descriptions[i]);
      },
    );
  }

  Widget _buildItemImage(int index) {
    return Image.asset(
      imageList[index],
      fit: BoxFit.cover,
    );
  }
}