import 'package:cloud_firestore/cloud_firestore.dart';

class SkincareRoutine {
  String faceWash;
  String toner;
  String moisturizer;
  String sunscreen;
  String lipBalm;
  String faceWashImageUrl;
  String tonerImageUrl;
  String moisturizerImageUrl;
  String sunscreenImageUrl;
  String lipBalmImageUrl;
  DateTime date;

  SkincareRoutine({
    required this.faceWash,
    required this.toner,
    required this.moisturizer,
    required this.sunscreen,
    required this.lipBalm,
    required this.faceWashImageUrl,
    required this.tonerImageUrl,
    required this.moisturizerImageUrl,
    required this.sunscreenImageUrl,
    required this.lipBalmImageUrl,
    required this.date,
  });

  // Convert a SkincareRoutine object to a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'faceWash': faceWash,
      'toner': toner,
      'moisturizer': moisturizer,
      'sunscreen': sunscreen,
      'lipBalm': lipBalm,
      'faceWashImageUrl': faceWashImageUrl,
      'tonerImageUrl': tonerImageUrl,
      'moisturizerImageUrl': moisturizerImageUrl,
      'sunscreenImageUrl': sunscreenImageUrl,
      'lipBalmImageUrl': lipBalmImageUrl,
      'date': date,
    };
  }

  // Create a SkincareRoutine object from a Map
  factory SkincareRoutine.fromMap(Map<String, dynamic> map) {
    return SkincareRoutine(
      faceWash: map['faceWash'],
      toner: map['toner'],
      moisturizer: map['moisturizer'],
      sunscreen: map['sunscreen'],
      lipBalm: map['lipBalm'],
      faceWashImageUrl: map['faceWashImageUrl'],
      tonerImageUrl: map['tonerImageUrl'],
      moisturizerImageUrl: map['moisturizerImageUrl'],
      sunscreenImageUrl: map['sunscreenImageUrl'],
      lipBalmImageUrl: map['lipBalmImageUrl'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
