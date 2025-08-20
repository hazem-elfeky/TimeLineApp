import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remago/core/services/services.dart';
import 'package:remago/data/static/eventModel.dart';
import 'package:remago/view/screen/home/addevent.dart';

class EventController extends GetxController {
  final RxList<EventModel> events = <EventModel>[].obs;
  final MyServices myServices = Get.find();

  void goToAddEventPage({EventModel? event, int? editIndex}) {
    Get.to(() => AddEventPage(event: event, editIndex: editIndex));
  }

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void loadEvents() {
    final saved = myServices.sharedPreferences.getStringList('events');
    if (saved != null) {
      events.assignAll(saved.map((e) => EventModel.fromJson(jsonDecode(e))));
    }
  }

  void saveEvents() {
    final data = events.map((e) => jsonEncode(e.toJson())).toList();
    myServices.sharedPreferences.setStringList('events', data);
  }

  void addEvent(EventModel event) {
    events.add(event);
    saveEvents();
    Get.back();
    Get.snackbar(
      'نجاح',
      'تم إضافة الحدث بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple,
      colorText: Colors.white,
    );
  }

  void updateEvent(int index, EventModel newEvent) {
    events[index] = newEvent;
    saveEvents();
    Get.back();
    Get.snackbar(
      'نجاح',
      'تم تعديل الحدث بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple,
      colorText: Colors.white,
    );
  }

  void deleteEvent(int index) {
    events.removeAt(index);
    saveEvents();
  }
}
