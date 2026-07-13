import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/features/services/deep_link_manager.dart';
import 'core/features/services/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService.instance.initialize(
    onNotificationTap: (payload) {
      if (payload != null) {
        DeepLinkManager.instance.handle(
          payload,
        );
      }
    },
  );

  runApp(
    const ProviderScope(
      child: PocketIQApp(),
    ),
  );
}