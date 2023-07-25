import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:what_sholud_i_do_now/presentation/calendar/utils.dart';
import '../../utils/hive_db.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  final _box = Hive.box('DB');
  final _alarmBox = Hive.box('ALARM');

  List<dynamic> _dataList = [];

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  Map<DateTime, List<Event>> events = {}; //달력에 표시될 데이터


  @override
  void initState() {
    super.initState();

    //로컬 노티 구성
    // _init();

    if(_box.get(HiveDB.cal) != null){
      _dataList = _box.get(HiveDB.cal);

      setState(() {
        for (var e in _dataList) {
          String act = e[HiveDB.act];
          DateTime date = e[HiveDB.date];
          DateTime time = DateTime.utc(date.year, date.month, date.day);
          String timeText = "${date.hour}시${date.minute}분";

          if (events[time] == null) {
            //해당시간에 목록이 존재하지 않으면 추가
            events[time] = [Event(act, timeText, date, false)];
          } else {
            //존재하면 리스트에 더한후 추가
            List<Event>? list = events[time];

            if( _alarmBox.get(date.toString()) != null){
              //알람이 설정되어 있는 경우
              if(date.isAfter(DateTime.now())){
                //현재시간이 알람시간 이전인 경우
                list?.add(Event(act,timeText, date, true));
              }else{
                //알람시간이 지난경우
                list?.add(Event(act,timeText, date, false));
              }
            }else{
              //알람이 설정되지 않은 경우
              list?.add(Event(act,timeText, date, false));
            }
            events[time] = list!;
          }
        }


      });
    }
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    DateTime time = DateTime.utc(day.year, day.month, day.day);
    return events[time] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  alarm (Event event) async {

     String time = event.time.toString();

     final id = DateTime.now().millisecondsSinceEpoch % 100000;

     //알람리스트가 비어있거나 해당시간에 알람이 포함 되어있지 않으면 새로 만듬
     if(_alarmBox.get(time) == null){

       final alarmSettings = AlarmSettings(
         id: id,
         dateTime: event.time,
         loopAudio: true,
         vibrate: true,
         notificationTitle: "예약된 활동",
         notificationBody: event.title,
         assetAudioPath: 'assets/music/marimba.mp3',
         enableNotificationOnKill: false,
       );

       Alarm.set(alarmSettings: alarmSettings).then((value) {
         //로컬DB에 알람 추가
         _alarmBox.put(time, alarmSettings.id);

         setState(() {
           event.alarm = true;
         });
         Fluttertoast.showToast(msg: "${event.timeText} 알람이 저장 되었습니다.");
       });


     }
     else {
       //기존 알람이 있으면 기존 알람 삭제
       var id = _alarmBox.get(time);

       Alarm.stop(id);
       _alarmBox.put(time, null);


       setState(() {
         event.alarm = false;
       });

       Fluttertoast.showToast(msg: "${event.timeText} 알람이 취소 되었습니다.");
     }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('활동 달력'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            locale: 'ko-KR',
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value[index].timeText, style: const TextStyle(fontSize: 11, color: Colors.grey),),
                                Text(value[index].title, style: const TextStyle(fontSize: 16,),),
                              ],
                            ),
                            const Spacer(),
                            IconButton(onPressed: (){

                             alarm(value[index]);
                            },
                                icon: value[index].alarm ? const FaIcon(FontAwesomeIcons.bell, color: Colors.lightGreen,) : const FaIcon(FontAwesomeIcons.bell))
                          ],
                        )
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
