import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance =
  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin
  _notifications =
  FlutterLocalNotificationsPlugin();

  Function(String?)? _onNotificationTap;

  Future<void> initialize({
    Function(String?)? onNotificationTap,
  }) async {
    _onNotificationTap = onNotificationTap;

    const android =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
    InitializationSettings(
      android: android,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (response) {
        _onNotificationTap?.call(
          response.payload,
        );
      },
    );

    // Handle notification tap when app was terminated
    final details =
    await _notifications
        .getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp ??
        false) {
      Future.delayed(
        const Duration(milliseconds: 300),
            () {
          _onNotificationTap?.call(
            details!
                .notificationResponse
                ?.payload,
          );
        },
      );
    }
  }

  Future<bool> requestPermission() async {
    final android =
    _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    return await android
        ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool> isPermissionGranted() async {
    final android =
    _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    return await android
        ?.areNotificationsEnabled() ??
        false;
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const android =
    AndroidNotificationDetails(
      'budget_alerts',
      'Budget Alerts',
      channelDescription:
      'Budget Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: android,
      ),
      payload: payload,
    );
  }
}