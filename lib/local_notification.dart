import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

StreamController newArticleController = StreamController.broadcast();

class LocalNoticeService {
  static final LocalNoticeService _notificationService =
      LocalNoticeService._internal();

  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory LocalNoticeService() {
    return _notificationService;
  }

  LocalNoticeService._internal();

  Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSetting =
        DarwinInitializationSettings(requestSoundPermission: true);

    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    await _localNotificationsPlugin
        .initialize(
          initSettings,
          onDidReceiveNotificationResponse: (details) {
            newArticleController.add(true);
          },
        )
        .then((_) {})
        .catchError((Object error) {});
  }

  void showLocalNotification(String title, String body) {
    const androidNotificationDetail =
        AndroidNotificationDetails('0', 'general');

    const iosNotificatonDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    _localNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}
