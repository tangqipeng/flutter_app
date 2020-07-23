import 'package:flutter/material.dart';
import 'package:flutter_app/banner.dart';
import 'package:flutter_app/banner_tinder.dart';
import 'package:flutter_app/gridview.dart';
import 'package:flutter_app/random.dart';

class HomePage extends StatefulWidget{

  @override
  State createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  
  TabController _controller;

  final List<String> imageList = [
    'images/home.png',
    'images/order.png',
    'images/chat.png',
    'images/my.png',
  ];

  @override
  void initState() {
    _controller = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          new RandomWords(),
          new BannerPage(),
          new BannerTINDERPage(),
          new GridViewPage(),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: new TabBar(
          controller: _controller,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black26,
          tabs: <Widget>[
            new Tab(
              text: '主页',
              icon: Image.asset(
                imageList[0],
                width: 25,
                height: 25,
              ),
            ),
            new Tab(
              text: '订单',
              icon: Image.asset(
                  imageList[1],
                  width: 25,
                  height: 25,
              ),
            ),
            new Tab(
              text: '聊天',
              icon: Image.asset(
                  imageList[2],
                  width: 25,
                  height: 25,
              ),
            ),
            new Tab(
              text: '我的',
              icon: Image.asset(
                  imageList[3],
                  width: 25,
                  height: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}