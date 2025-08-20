import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remago/controller/addevent_controller.dart';
import 'package:remago/data/static/eventModel.dart';

class AddEventPage extends StatelessWidget {
  final EventModel? event;
  final int? editIndex;

  const AddEventPage({super.key, this.event, this.editIndex});

  @override
  Widget build(BuildContext context) {
    final addCtrl = Get.put(
      AddEventController(event: event, editIndex: editIndex),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(event == null ? 'أضف الحدث' : 'تعديل الحدث'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: addCtrl.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: addCtrl.nameCtrl,
                decoration: const InputDecoration(
                  hintText: 'اسم الحدث',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'أدخل اسم الحدث' : null,
              ),
              const SizedBox(height: 16),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () => addCtrl.pickDateTime(context),
                  child: Text(
                    addCtrl.selectedDateLabel,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 12,
                    ),
                  ),
                  onPressed: addCtrl.submit,
                  child: Text(
                    editIndex != null ? 'تعديل' : 'إضافة',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
