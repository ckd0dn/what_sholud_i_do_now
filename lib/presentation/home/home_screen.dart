import 'package:flutter/material.dart';
import 'package:what_sholud_i_do_now/presentation/activity/activity_screen.dart';
import 'package:what_sholud_i_do_now/presentation/calendar/calendar_screen.dart';

import '../favorite/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  int _index = 0;

  final List _pages = [
    const ActivityScreen(),
    const FavoriteScreen(),
    const CalendarScreen()
  ];

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: (){
                      //TODO 앱에 대한 도움말 가져올 Drawer등 만들기
                  },
                  child: const Icon(
                    Icons.info_outline,
                    size: 24,
                  ),
                ),)
          ],
          title: const Text(
            "지금 뭐하지",
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
        ),
        body: _pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
              ),
              label: '즐겨찾기',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
              ),
              label: '달력',
            ),
          ],
          currentIndex: _index, // 지정 인덱스로 이동
          selectedItemColor: Colors.teal[400],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          }, // 선언했던 onItemTapped
        ),
      ),
    );
  }
}
