// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:athma_kalari_app/features/courses/models/subscription_course_model.dart';

class UserModel {
  String? id;
  String? name;
  String? registerNumber;
  String? bloodGroup;
  String? gender;
  String? address;
  String? phoneNumber;
  String? image;
  List<SubscriptionCourseModel>? subSCriptionCourses;
  List<dynamic>? myCourses;
  List<dynamic>? keywords;
  Timestamp? createdAt;
  String? fcmToken;
  UserModel({
    this.id,
    this.name,
    this.registerNumber,
    this.bloodGroup,
    this.gender,
    this.address,
    this.phoneNumber,
    this.image,
    this.subSCriptionCourses,
    this.keywords,
    this.createdAt,
    this.myCourses,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'registerNumber': registerNumber,
      'bloodGroup': bloodGroup,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber,
      'image': image,
      'mySubscription': subSCriptionCourses?.map((x) => x.toMap()).toList(),
      'keywords': keywords,
      'createdAt': createdAt,
      'myCourses': myCourses,
      'fcmToken': fcmToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : "Unknown",
      registerNumber: map['registerNumber'] != null
          ? map['registerNumber'] as String
          : null,
      bloodGroup:
          map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      subSCriptionCourses: map['mySubscription'] != null
          ? List<SubscriptionCourseModel>.from(
              (map['mySubscription']).map<SubscriptionCourseModel?>(
                (x) =>
                    SubscriptionCourseModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      keywords: map['keywords'],
      createdAt: map['createdAt'],
      myCourses: map['myCourses'],
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? registerNumber,
    String? bloodGroup,
    String? gender,
    String? address,
    String? phoneNumber,
    String? image,
    List<SubscriptionCourseModel>? subSCriptionCourses,
    List<String>? keywords,
    Timestamp? createdAt,
    List<String>? myCourses,
    String? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      registerNumber: registerNumber ?? this.registerNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      subSCriptionCourses: subSCriptionCourses ?? this.subSCriptionCourses,
      keywords: keywords ?? this.keywords,
      createdAt: createdAt ?? this.createdAt,
      myCourses: myCourses ?? this.myCourses,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
