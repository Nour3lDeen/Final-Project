/*
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:bloc/bloc.dart';

import '../../../model/reminder/plant_reminder.dart';


part 'reminder_state.dart';


class ReminderCubit extends Cubit<ReminderState> {
  List<PlantReminder> reminders = [];

  ReminderCubit() : super(ReminderInitial()) {
    _initializeNotifications();
    _loadReminders();
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null, // Use default app icon
      [
        NotificationChannel(
          channelKey: 'plant_watering_channel',
          channelName: 'Plant Watering Reminders',
          channelDescription: 'Reminders for watering your plants',
          importance: NotificationImportance.High,
          defaultColor: Colors.green,
          ledColor: Colors.green,
          playSound: true,
          enableVibration: true,
        )
      ],
    );
  }

  Future<void> _loadReminders() async {
    emit(RemindersLoaded(reminders));
  }

  Future<void> addReminder(PlantReminder reminder) async {
    if (reminders.any((r) => r.plant.id == reminder.plant.id)) {
      emit(ReminderError('You already have a reminder for this plant'));
      return;
    }

    reminders.add(reminder);
    await _scheduleNotification(reminder);
    await _saveReminders();
    emit(RemindersLoaded(List.from(reminders)));
  }

  Future<void> _scheduleNotification(PlantReminder reminder) async {
    if (!reminder.isActive) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder.id.hashCode,
        channelKey: 'plant_watering_channel',
        title: 'Time to water your ${reminder.plant.name}!',
        body: reminder.plant.careTips,
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'WATERED',
          label: 'Mark as Watered',
        ),
      ],
      schedule: NotificationInterval(
        interval: Duration(seconds: reminder.frequencyDays * 24 * 60 * 60), // Convert days to seconds
        repeats: true,
      ),
    );
  }

  Future<void> toggleReminder(String id) async {
    final index = reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      final updated = PlantReminder(
        id: reminders[index].id,
        plant: reminders[index].plant,
        time: reminders[index].time,
        isActive: !reminders[index].isActive,
      );

      reminders[index] = updated;

      if (updated.isActive) {
        await _scheduleNotification(updated);
      } else {
        await AwesomeNotifications().cancel(updated.id.hashCode);
      }

      await _saveReminders();
      emit(RemindersLoaded(List.from(reminders)));
    }
  }

  Future<void> deleteReminder(String id) async {
    await AwesomeNotifications().cancel(id.hashCode);
    reminders.removeWhere((r) => r.id == id);
    await _saveReminders();
    emit(RemindersLoaded(List.from(reminders)));
  }

  Future<void> _saveReminders() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> rescheduleAllActiveReminders() async {
    for (final reminder in reminders.where((r) => r.isActive)) {
      await _scheduleNotification(reminder);
    }
  }
}*/
