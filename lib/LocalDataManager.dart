import 'repeaters.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class LocalDataManager{
  static RepeatersList repeaters;

  static void initStorage() {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10*1000*1000); // 10MB
    reloadRepeaters();
  }

  static Future <RepeatersList> reloadRepeaters() async {
    var snapshot = await FirebaseDatabase.instance.reference().once();
    repeaters = RepeatersList.fromJson(snapshot.value);
    return repeaters;
  }
}