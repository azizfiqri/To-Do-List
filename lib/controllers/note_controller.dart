import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  var date = 0.obs;
  var month = "".obs;
  var day = "".obs;
  var year = "".obs;

  Stream<QuerySnapshot> notesStream;

  insertNote(String note) {
    FirebaseFirestore.instance.collection('notes').add({
      'completed': false,
      'text': note,
    });
    Get.back();
    Get.snackbar(
      "Inserted Successfully",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(15.0),
    );
  }

  toggleTask(var ref, bool completed) {
    ref.update({
      'completed': !completed,
    });
  }

  deleteNote(var ref) {
    ref.delete();
    Get.snackbar(
      "Note Deleted Successfully",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(15.0),
    );
  }

  updateNote(var ref, String data) {
    ref.update({
      'text': data,
    });
    Get.back();
    Get.snackbar(
      "Note Updated Successfully",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.lightGreen,
      margin: EdgeInsets.all(15.0),
    );
  }

  @override
  void onInit() {
    notesStream = FirebaseFirestore.instance.collection('notes').snapshots();
    var d = DateTime.now();
    year.value = d.year.toString();
    date.value = d.day;
    switch (d.weekday) {
      case 0:
        day.value = "Minggu";
        break;
      case 1:
        day.value = "Senin";
        break;
      case 2:
        day.value = "Selasa";
        break;
      case 3:
        day.value = "Rabu";
        break;
      case 4:
        day.value = "Kamis";
        break;
      case 5:
        day.value = "Jum'at";
        break;
      case 6:
        day.value = "Sabtu";
        break;
    }

    switch (d.month) {
      case 0:
        month.value = "Januari";
        break;
      case 1:
        month.value = "Februari";
        break;
      case 2:
        month.value = "Maret";
        break;
      case 3:
        month.value = "April";
        break;
      case 4:
        month.value = "Mei";
        break;
      case 5:
        month.value = "Juni";
        break;
      case 6:
        month.value = "Juli";
        break;
      case 7:
        month.value = "Agustus";
        break;
      case 8:
        month.value = "September";
        break;
      case 9:
        month.value = "Oktober";
        break;
      case 10:
        month.value = "November";
        break;
      case 11:
        month.value = "Desember";
        break;
    }

    super.onInit();
  }
}
