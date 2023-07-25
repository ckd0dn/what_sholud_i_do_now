import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:what_sholud_i_do_now/presentation/activity/activity_screen.dart';
import 'package:what_sholud_i_do_now/presentation/calendar/calendar_screen.dart';

import '../alarm/edit_alarm.dart';
import '../alarm/ring.dart';
import '../favorite/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  final int pageIndex;

  const HomeScreen({Key? key, required this.pageIndex}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  int _index = 0;

  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;


  final List _pages = [
    const ActivityScreen(),
    const FavoriteScreen(),
    const CalendarScreen()
  ];

  @override
  void initState() {
    _index = widget.pageIndex;

    scrollController = ScrollController();

    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
          (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //알람 읽기
  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  //알람 리슨시 해당 화면 이동
  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    if(mounted){
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RingScreen(alarmSettings: alarmSettings),
          ));
    }

    loadAlarms();
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
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          width: double.infinity,
                          height: 600,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 238, 238, 238),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "· 버튼을 누르면 랜덤으로 활동이 주어집니다.",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "· 5번 뽑기시 더 많은 활동을 뽑기위해 광고 시청이 필요합니다.",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "· 뽑은 활동을 누르면 즐겨찾기에 저장이 가능합니다.",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "· 즐겨찾기 화면에서는 활동 예약이 가능하고 달력화면에 표시됩니다.",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "· 달력화면에서는 예약된 활동을 확인 할 수 있습니다.",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "· 앱 종료시 알람이 울리지 않습니다.",
                                    style: TextStyle(fontSize: 13, color: Colors.red),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.indigo,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "확인",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                },
                child: const Icon(
                  Icons.info_outline,
                  size: 24,
                ),
              ),
            )
          ],
          title: const Text(
            "오늘 뭐하지",
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
