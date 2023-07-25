import 'dart:ffi';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RingScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;

  const RingScreen({Key? key, required this.alarmSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    //울린 알람 로컬에서 지워주기
    final alarmBox = Hive.box('ALARM');
    alarmBox.put(alarmSettings.dateTime.toString(), null);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${alarmSettings.notificationTitle}\n${alarmSettings.notificationBody}",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Text("🔔", style: TextStyle(fontSize: 50)),
              RawMaterialButton(
                onPressed: () {
                  Alarm.stop(alarmSettings.id)
                      .then((_) => Navigator.pop(context));
                },
                child: Text(
                  "중단",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
