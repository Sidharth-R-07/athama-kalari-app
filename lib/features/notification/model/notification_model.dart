// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? title;
  String? subTitle;
  Timestamp? createdAt;
  String? type;
  String? id;
  NotificationModel({
    this.title,
    this.subTitle,
    this.createdAt,
    this.type,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subTitle': subTitle,
      'createdAt': createdAt,
      'type': type,
      'id': id,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] != null ? map['title'] as String : null,
      subTitle: map['subTitle'] != null ? map['subTitle'] as String : null,
      createdAt: map['createdAt'],
      type: map['type'] != null ? map['type'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  NotificationModel copyWith({
    String? title,
    String? subTitle,
    Timestamp? createdAt,
    String? type,
    String? id,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }
}
