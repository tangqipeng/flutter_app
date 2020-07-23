import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'banner_tinder.dart';
import 'gridview.dart';

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

class BannerPage extends StatefulWidget {
  @override
  State createState() {
    return new BannerPageState();
  }
}

class BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BannerShow'),
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return new Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: _buildSwiper(),
        ),
        Center(
            child: SizedBox.fromSize(
              size: Size.fromHeight(180.0),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: descriptions[index]);
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (context) => new BannerTINDERPage(),
                          ),
                        );
                      },
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
                viewportFraction: 0.8,
                scale: 0.85,
                autoplay: true,
                //            onTap: (int index) {
                //              Fluttertoast.showToast(msg: '点击了第$index个');
                //              Navigator.of(context).push(
                //                new MaterialPageRoute(
                //                  builder: (context) => new BannerTINDERPage(),
                //                ),
                //              );
                //            },
              ),
            )),
        Center(
          child: SizedBox.fromSize(
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
              layout: SwiperLayout.CUSTOM,
              customLayoutOption:
              new CustomLayoutOption(startIndex: -1, stateCount: 3)
                  .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
                new Offset(-370.0, -40.0),
                new Offset(0.0, 0.0),
                new Offset(370.0, -40.0)
              ]),
              itemWidth: 300.0,
              itemHeight: 180.0,
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
      control: new SwiperControl(
        iconPrevious: Icons.arrow_back_ios,
        iconNext: Icons.arrow_forward_ios,
      ),
      duration: 300,
      scrollDirection: Axis.horizontal,
      autoplay: true,
      onTap: (int i) {
        Fluttertoast.showToast(msg: descriptions[i]);
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context) => new GridViewPage(),
          ),
        );
      },
    );
  }

  Widget _buildItemImage(int index) {
    return Image.asset(
      imageList[index],
      fit: BoxFit.cover
    );
  }
}
