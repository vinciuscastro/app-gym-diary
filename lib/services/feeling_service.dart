import 'package:app_gym_yt/models/feeling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeelingService {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFeeling(String exerciseId, Feeling feeling) async {
    try {
      await _firestore.collection(userId).doc(exerciseId).collection("feelings").doc(feeling.id).set(feeling.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream <List<Feeling>> getFeelings(String exerciseId) {
    return _firestore.collection(userId).doc(exerciseId).collection("feelings").snapshots().map((snapshot) => snapshot.docs.map((doc) => Feeling.fromJson(doc.data())).toList());
  }

  Future<void> deleteFeeling(String exerciseId, String feelingId) async {
    try {
      await _firestore.collection(userId).doc(exerciseId).collection("feelings").doc(feelingId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}