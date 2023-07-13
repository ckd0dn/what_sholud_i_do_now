import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:what_sholud_i_do_now/presentation/activity/activity_state.dart';
import 'package:what_sholud_i_do_now/utils/hive_db.dart';

import '../../domain/repository/activity_repository.dart';


class ActivityViewModel with ChangeNotifier {

  final ActivityRepository _activityRepository;

  var _state = const ActivityState();

  ActivityState get state => _state;

  final box = Hive.box('DB');

  List<String> favoriteActivity = []; // 활동 즐겨찾기 목록

  List<dynamic> calendarActivity = []; // 예약 활동 달력 목록

  int getActivityCount = 0; // 광고 띄우기 위한 할일뽑기 횟수 카운트


  ActivityViewModel(this._activityRepository) {
    if(box.get(HiveDB.fav) != null ){
      favoriteActivity.addAll(box.get(HiveDB.fav));
    }

    if(box.get(HiveDB.cal) != null ){
      List<dynamic> list = box.get(HiveDB.cal);
      calendarActivity.addAll(list);
    }

    print('즐겨찾기 >> $favoriteActivity}');
    print('달력 >> $calendarActivity}');

  }


  Future getActivity(String type, String participants, String price,
      String accessibility) async {
    getActivityCount++;

    _state = state.copyWith(
      isLoading: true,
      isActivity: true,

    );

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500), () {});


    final result = await _activityRepository.getActivity(
        type, participants, price, accessibility);

    result.when(
      success: (data) {
        _state = state.copyWith(
          activity: data,
        );
      },
      error: (e) {
        if (kDebugMode) {
          print("활동 조회 에러");
        }
        if (kDebugMode) {
          print(e);
        }
      },
    );

    _state = state.copyWith(
      isLoading: false,
    );

    notifyListeners();
  }

  //즐겨찾기에 추가
  void addFavoriteList() {
    if (favoriteActivity.contains(state.activity.activity)) {
      Fluttertoast.showToast(
          msg: "이미 즐겨찾기에 추가된 일입니다", gravity: ToastGravity.CENTER);
    } else {
      favoriteActivity.add(state.activity.activity);

      box.put(HiveDB.fav, favoriteActivity);

      print(box.get(HiveDB.fav));

      notifyListeners();
    }
  }

  //즐겨찾기에서 삭제
  void delFavoriteList(int idx) {
    favoriteActivity.removeAt(idx);

    box.put(HiveDB.fav, favoriteActivity);

    print(box.get(HiveDB.fav));

    notifyListeners();
  }

  //활동 예약 (달력에 추가)
  void addCalendarActivity(int idx, DateTime time) {
    Map<String, dynamic> map = {
      HiveDB.act: favoriteActivity[idx],
      HiveDB.date: time,
    };

    calendarActivity.add(map);

    box.put(HiveDB.cal, calendarActivity);

    //예약된 즐겨찾기 지우기
    favoriteActivity.removeAt(idx);

    notifyListeners();
  }


}