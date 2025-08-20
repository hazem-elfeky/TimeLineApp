import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remago/controller/event_controller.dart';
import 'package:remago/data/static/eventModel.dart';

class AddEventController extends GetxController {
  AddEventController({
    this.event,
    this.editIndex,
    EventController? eventController,
  }) : _eventController = eventController ?? Get.find<EventController>();

  final EventController _eventController;

  final EventModel? event;
  final int? editIndex;

  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final RxInt selectedSeconds = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (event != null) {
      nameCtrl.text = event!.name;
      selectedDate.value = event!.date;
      selectedSeconds.value = event!.date.second;
    }
  }

  String get selectedDateLabel {
    final d = selectedDate.value;
    if (d == null) return 'اختر التاريخ والوقت';
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(d.day)}-${two(d.month)}-${d.year} '
        '${two(d.hour)}:${two(d.minute)}:${two(d.second)}';
  }

  Future<void> pickDateTime([BuildContext? context]) async {
    final ctx = context ?? Get.context;
    if (ctx == null) return;

    final now = DateTime.now();

    final date = await showDatePicker(
      context: ctx,
      initialDate: selectedDate.value ?? now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: ctx,
      initialTime: TimeOfDay.fromDateTime(selectedDate.value ?? now),
    );
    if (time == null) return;

    var tempSeconds = selectedSeconds.value;
    await Get.dialog(
      AlertDialog(
        title: const Text('اختر الثواني'),
        content: StatefulBuilder(
          builder: (c, setSt) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => setSt(() {
                  tempSeconds = (tempSeconds - 1) < 0 ? 59 : tempSeconds - 1;
                }),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(
                tempSeconds.toString().padLeft(2, '0'),
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => setSt(() {
                  tempSeconds = (tempSeconds + 1) % 60;
                }),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              selectedSeconds.value = tempSeconds;
              Get.back();
            },
            child: const Text('تم'),
          ),
        ],
      ),
    );

    selectedDate.value = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
      selectedSeconds.value,
    );
  }

  void submit() {
    final d = selectedDate.value;
    if (!(formKey.currentState?.validate() ?? false) || d == null) return;

    final model = EventModel(name: nameCtrl.text.trim(), date: d);

    if (editIndex != null) {
      _eventController.updateEvent(editIndex!, model);
    } else {
      _eventController.addEvent(model);
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    super.onClose();
  }
}
