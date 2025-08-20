import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remago/view/widget/home/circularTime.dart';

class CountdownCircles extends StatefulWidget {
  final DateTime endDate;
  const CountdownCircles({required this.endDate});

  @override
  State<CountdownCircles> createState() => _CountdownCirclesState();
}

class _CountdownCirclesState extends State<CountdownCircles> {
  late Timer _timer;
  Duration _diff = Duration.zero;

  @override
  void initState() {
    super.initState();
    _recalc();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(_recalc);
    });
  }

  void _recalc() {
    final now = DateTime.now();
    _diff = widget.endDate.difference(now);
    if (_diff.isNegative) _diff = Duration.zero;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int days = _diff.inDays;
    final int hours = _diff.inHours % 24;
    final int minutes = _diff.inMinutes % 60;
    final int seconds = _diff.inSeconds % 60;

    final bool finished = _diff == Duration.zero;

    return finished
        ? const Text('تم انتهاء الحدث', style: TextStyle(color: Colors.red))
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [],
          ).buildWithChildren([
            CircleTimer(label: 'ثواني', value: seconds, max: 60),
            CircleTimer(label: 'دقائق', value: minutes, max: 60),
            CircleTimer(label: 'ساعات', value: hours, max: 24),
            CircleTimer(label: 'أيام', value: days, max: 365),
          ]);
  }
}

extension _WidgetList on Widget {
  Widget buildWithChildren(List<Widget> children) {
    if (this is Row) {
      final row = this as Row;
      return Row(
        key: row.key,
        mainAxisAlignment: row.mainAxisAlignment,
        mainAxisSize: row.mainAxisSize,
        crossAxisAlignment: row.crossAxisAlignment,
        textDirection: row.textDirection,
        verticalDirection: row.verticalDirection,
        textBaseline: row.textBaseline,
        children: children,
      );
    }
    return this;
  }
}
