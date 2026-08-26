import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealtimeClock extends StatefulWidget {
  const RealtimeClock({super.key});

  @override
  State<RealtimeClock> createState() => _RealtimeClockState();
}

class _RealtimeClockState extends State<RealtimeClock> {
  late String currentTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    currentTime = _formatTime(DateTime.now());

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = _formatTime(DateTime.now());
      });
    });
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTime,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
