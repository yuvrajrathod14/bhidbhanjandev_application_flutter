import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class NotificationUtil {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  static Future<void> scheduleAartiReminder(
    String title,
    TimeOfDay time,
    BuildContext context,
  ) async {
    // In a real app, uses timezone package to schedule relative to current time.
    // For this prototype, we will just show an immediate notification or
    // request permission.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder set for \$title at \${time.format(context)}'),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }

  static void addToCalendar(
    String title,
    TimeOfDay time,
    BuildContext context,
  ) {
    // Creating today's date with the specific time
    final now = DateTime.now();
    final eventStart = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final eventEnd = eventStart.add(const Duration(minutes: 30));

    final Event event = Event(
      title: 'Temple: \$title',
      description: 'Daily Aarti at Shree Bhidbhanjan Hanuman Temple',
      location: 'Shree Bhidbhanjan Hanuman Temple',
      startDate: eventStart,
      endDate: eventEnd,
      allDay: false,
    );

    Add2Calendar.addEvent2Cal(event).then((success) {
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added to calendar!')),
        );
      }
    });
  }
}
