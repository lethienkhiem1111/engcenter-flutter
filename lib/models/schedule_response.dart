
import 'package:englcenterapp/models/schedule.dart';

class ScheduleResponse {
  final String error;
  // final String result;
  final List<Schedule> schedules;

  ScheduleResponse({this.schedules, this.error});

  factory ScheduleResponse.fromJson(Map<String, dynamic> jsonScheduleResponse) {
    if((jsonScheduleResponse['data'][0]['tuans'] as List).isEmpty) {
      return ScheduleResponse(
      schedules: [],
      error: 'Thời khóa biểu chưa cập nhập'
    );
    }
    return ScheduleResponse(
      schedules: (jsonScheduleResponse['data'][0]['tuans'] as List).map((i) => Schedule.fromJson(i)).toList(),
      error: ''
    );
  }

  factory ScheduleResponse.withError(String error) {
    return ScheduleResponse(
      schedules: [],
      error: error
    );
  }
}
