import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remago/controller/event_controller.dart';
import 'package:remago/data/static/eventModel.dart';
import 'package:remago/view/widget/home/countdowncircles.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final int index;
  final EventController controller;

  const EventCard({
    super.key,
    required this.event,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bool expired = event.date.isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    expired ? '${event.name} (منتهي)' : event.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'تعديل',
                      icon: const Icon(Icons.edit, color: Colors.purple),
                      onPressed: () {
                        controller.goToAddEventPage(
                          event: controller.events[index],
                          editIndex: index,
                        );
                      },
                    ),
                    IconButton(
                      tooltip: 'حذف',
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'تحذير',
                          middleText: 'هل تريد حذف الحدث؟',
                          textConfirm: 'حذف',
                          textCancel: 'إلغاء',
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.deleteEvent(index);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            CountdownCircles(endDate: event.date),
            const SizedBox(height: 8),
            Text(
              '${event.date.day}-${event.date.month}-${event.date.year} '
              '${event.date.hour.toString().padLeft(2, '0')}:${event.date.minute.toString().padLeft(2, '0')}',
              style: TextStyle(color: expired ? Colors.red : Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
