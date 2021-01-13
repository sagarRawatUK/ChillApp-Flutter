import 'dart:async';
import 'dart:convert';

import 'package:ChillApp/helper/database.dart';
import 'package:android_notification_listener2/android_notification_listener2.dart';

class NotificationMethods {
  Databasemethods databasemethods = Databasemethods();
  AndroidNotificationListener notifications;
  StreamSubscription<NotificationEventV2> subscription;

  void startListening() {
    notifications = new AndroidNotificationListener();
    try {
      subscription = notifications.notificationStream.listen(onData);
    } on NotificationExceptionV2 catch (exception) {
      print(exception);
    }
  }

  void onData(NotificationEventV2 event) {
    if (event.packageName == "com.android.mms") {
      Map<String, dynamic> notiMap = {
        // "text": event.packageText,
        "message": event.packageMessage,
        "time": event.timeStamp,
        "Json": event.packageExtra
      };
      databasemethods.smsNotification(notiMap, event.packageText);
    }
    if (event.packageName == "com.whatsapp") {
      Map<String, dynamic> notiMap = {
        // "text": event.packageText,
        "message": event.packageMessage,
        "time": event.timeStamp,
        "Json": event.packageExtra
      };
      databasemethods.whatsAppNotification(notiMap, event.packageText);
    }
    if (event.packageName == "com.instagram.android") {
      Map<String, dynamic> notiMap = {
        // "text": event.packageText,
        "message": event.packageMessage,
        "time": event.timeStamp,
        "Json": event.packageExtra
      };
      databasemethods.instapNotification(notiMap, event.packageText);
    }
    print('converting package extra to json');
    var jsonDatax = jsonDecode(event.packageExtra);
    print(jsonDatax);
  }
}
