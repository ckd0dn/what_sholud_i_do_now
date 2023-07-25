import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:what_sholud_i_do_now/data/source/remote/bored_api.dart';
import 'package:what_sholud_i_do_now/data/source/remote/google_translation_api.dart';
import 'package:what_sholud_i_do_now/domain/model/activity.dart';
import 'package:what_sholud_i_do_now/domain/repository/activity_repository.dart';
import 'package:what_sholud_i_do_now/utils/result.dart';

class ActivityRepositoryImpl implements ActivityRepository{

  final BoredApi _boredApi;
  final GoogleTranslationApi _googleTranslationApi;

  ActivityRepositoryImpl(this._boredApi, this._googleTranslationApi);

  @override
  Future<Result<Activity>> getActivity(String type, String participants, String price, String accessibility) async {


    try {
      final response = await _boredApi.getActivity(type, participants, price, accessibility);
      var data = json.decode(response.body);
      Activity listing = Activity.fromJson(data);
      String activity = listing.activity;
      String translationActivity = await _googleTranslationApi.getTranslationGoogle(activity);

      Activity translationListing =  listing.copyWith(
        activity: translationActivity.toString()
      );

      return Result.success(translationListing);
    }catch (e) {
      if (kDebugMode) {

      }
      return Result.error(Exception('데이터 로드 실패'));
    }

  }

}