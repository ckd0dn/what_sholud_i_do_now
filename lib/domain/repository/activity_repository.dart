import '../../utils/result.dart';
import '../model/activity.dart';

abstract class ActivityRepository {

  Future<Result<Activity>> getActivity(String type, String participants, String price, String accessibility);

}