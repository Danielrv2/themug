import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> intializeNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(settings);
}

Future<void> showNotification(
    {required int id, required String title, required String body}) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'channel_id',
    'chanel_name',
    channelDescription: 'description',
    importance: Importance.max,
    priority: Priority.max,
    playSound: true,
  );

  const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

  const details =  NotificationDetails(
      android: androidNotificationDetails, iOS: darwinNotificationDetails);

  await flutterLocalNotificationsPlugin.show(id, title, body, details);
}

