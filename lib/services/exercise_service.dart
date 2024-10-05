import 'package:app_gym_yt/models/exercise.dart';
import 'package:app_gym_yt/models/feeling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExerciseService {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExercise(Exercise exercise) async {
    try {
      //  await _firestore.collection('users').doc(userId).collection('exercises').add(exercise.toJson());
      await _firestore.collection(userId).doc(exercise.id).set(exercise.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addFeelings(String exerciseId, Feeling feeling) async {
    try {
      await _firestore.collection(userId).doc(exerciseId).collection("feelings").doc(feeling.id).set(feeling.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<List<Exercise>> getExercises({required bool isDesc}) {
    return _firestore.collection(userId).orderBy("description", descending: isDesc).snapshots().map((snapshot) => snapshot.docs.map((doc) => Exercise.fromJson(doc.data())).toList());
  }

  Future<void> deleteExercise(String id) async {
    try {
      await _firestore.collection(userId).doc(id).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}