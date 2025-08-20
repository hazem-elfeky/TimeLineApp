import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remago/controller/event_controller.dart';
import 'package:remago/core/constant/imageasset.dart';
import 'package:remago/view/widget/home/cardevent.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController controller = Get.put(EventController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('كم باقي من الوقت'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.goToAddEventPage();
            },
          ),
        ],
      ),
      body: Obx(() {
        final hasEvents = controller.events.isNotEmpty;

        if (!hasEvents) {
          return Stack(
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    AppImageAsset.logo,
                    width: 220,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 28,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      controller.goToAddEventPage();
                    },

                    child: const Text(
                      'أضف الحدث الآن',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: controller.events.length,
          itemBuilder: (context, index) {
            final event = controller.events[index];
            return EventCard(
              event: event,
              index: index,
              controller: controller,
            );
          },
        );
      }),
    );
  }
}
