
import 'package:englcenterapp/models/schedule_response.dart';
import 'package:englcenterapp/models/week.dart';

class Schedules {
  final List<ScheduleResponse> schedules;
  final String error;

  Schedules(this.schedules, this.error);

  Schedules.fromJson(List<ScheduleResponse> scheduleResponse):
    schedules = scheduleResponse,
    error = '';

  Schedules.withError(String error):
      schedules = [],
      error = error;
}