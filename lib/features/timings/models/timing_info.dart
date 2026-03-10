import 'package:flutter/material.dart';

class TimingInfo {
  final String title;
  final TimeOfDay time;
  final String description;
  final IconData icon;

  const TimingInfo({
    required this.title,
    required this.time,
    required this.description,
    required this.icon,
  });

  String get formattedTime {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hr12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${hr12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}

// Dummy data for standard daily temple timings
final List<TimingInfo> dailyTimings = [
  const TimingInfo(
    title: 'Mangla Aarti',
    time: TimeOfDay(hour: 5, minute: 30),
    description: 'First aarti of the day to awaken the deity.',
    icon: Icons.wb_twilight_rounded,
  ),
  const TimingInfo(
    title: 'Shangar Aarti',
    time: TimeOfDay(hour: 7, minute: 30),
    description: 'Aarti performed after adorning the deity.',
    icon: Icons.flare_rounded,
  ),
  const TimingInfo(
    title: 'Rajbhog',
    time: TimeOfDay(hour: 11, minute: 30),
    description: 'Mid-day offering of food to the deity.',
    icon: Icons.restaurant_rounded,
  ),
  const TimingInfo(
    title: 'Sandhya Aarti',
    time: TimeOfDay(hour: 19, minute: 0),
    description: 'Evening aarti performed at sunset.',
    icon: Icons.nights_stay_rounded,
  ),
  const TimingInfo(
    title: 'Shayan Aarti',
    time: TimeOfDay(hour: 21, minute: 30),
    description: 'Final aarti before the deity rests for the night.',
    icon: Icons.bedtime_rounded,
  ),
];
