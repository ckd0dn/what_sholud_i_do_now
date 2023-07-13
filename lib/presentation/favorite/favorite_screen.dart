import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../activity/activity_view_model.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivityViewModel>();
    final state = viewModel.state;

    void onTimeChanged(DateTime? dateTime, String text) {

      final snackBar =
      SnackBar(
          content: Text("$text 활동이\n${dateTime?.year}년 ${dateTime?.month}월 ${dateTime?.day}일 ${dateTime?.hour}시 ${dateTime?.minute}분에 예약되었습니다"),
          duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "일정에 맞춰 활동을 달력에 예약해보세요!",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: viewModel.favoriteActivity.length,
                  itemBuilder: (context, idx){
                    return Container(
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(viewModel.favoriteActivity[idx]),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextButton(
                                  onPressed: () {
                                    viewModel.delFavoriteList(idx);
                                  },
                                  child: const Text(
                                    "삭제",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),),
                              TextButton(
                                onPressed: () async {

                                  DateTime? dateTime = await showOmniDateTimePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                    DateTime(1600).subtract(const Duration(days: 3652)),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 3652),
                                    ),
                                    is24HourMode: false,
                                    isShowSeconds: false,
                                    minutesInterval: 1,
                                    secondsInterval: 1,
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    constraints: const BoxConstraints(
                                      maxWidth: 350,
                                      maxHeight: 650,
                                    ),
                                    transitionBuilder: (context, anim1, anim2, child) {
                                      return FadeTransition(
                                        opacity: anim1.drive(
                                          Tween(
                                            begin: 0,
                                            end: 1,
                                          ),
                                        ),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    selectableDayPredicate: (dateTime) {
                                      // Disable 25th Feb 2023
                                      if (dateTime == DateTime(2023, 2, 25)) {
                                        return false;
                                      } else {
                                        return true;
                                      }
                                    },
                                  ).then((dateTime) {
                                    if(dateTime != null) {
                                      onTimeChanged(dateTime, viewModel.favoriteActivity[idx]);
                                      viewModel.addCalendarActivity(idx, dateTime);
                                    }else {
                                      Fluttertoast.showToast(msg: "예약에 실패하였습니다.");
                                    }
                                    return null;
                                  });


                                },
                                child: const Text(
                                  '예약',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
