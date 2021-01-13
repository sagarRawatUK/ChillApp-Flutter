import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Databasemethods {
  String platformId;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  void whatsAppNotification(Map<String, dynamic> notiMap, String contact) {
    var whtsappCollection = FirebaseFirestore.instance.collection("Whatsapp");
    whtsappCollection
        .doc(date)
        .collection(contact)
        .add(notiMap)
        .then((value) => print(value));
  }

  void instapNotification(Map<String, dynamic> notiMap, String contact) {
    var instaCollection = FirebaseFirestore.instance.collection("Instagram");
    instaCollection
        .doc(date)
        .collection(contact)
        .add(notiMap)
        .then((value) => print(value));
  }

  void smsNotification(Map<String, dynamic> notiMap, String contact) {
    var smsCollection = FirebaseFirestore.instance.collection("SMS");
    smsCollection
        .doc(date)
        .collection(contact)
        .add(notiMap)
        .then((value) => print(value));
  }
}
