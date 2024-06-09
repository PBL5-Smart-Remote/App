import 'dart:async';
import 'package:cron/cron.dart';

class CronJob {
  CronJob._privateConstructor();
  static final CronJob _instance = CronJob._privateConstructor();
  static CronJob get instance => _instance;

  final cron = Cron();
  Map<String, ScheduledTask> jobs = {};

  void addSchedule({
    dynamic seconds, 
    dynamic minutes,
    dynamic hours,
    dynamic days,
    dynamic months,
    dynamic weekDays,
    required FutureOr<dynamic> Function() action,
  }) {
    
    final schedule = Schedule(
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: days,
      months: months,
      weekdays: weekDays
    );

    cron.schedule(schedule, action);
  }
}

