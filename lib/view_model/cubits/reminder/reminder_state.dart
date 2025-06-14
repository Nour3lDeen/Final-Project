/*
part of 'reminder_cubit.dart';

@immutable
sealed class ReminderState {}

class ReminderInitial extends ReminderState {}

class RemindersLoaded extends ReminderState {
  final List<PlantReminder> reminders;
  RemindersLoaded(this.reminders);
}

class ReminderError extends ReminderState {
  final String message;
  ReminderError(this.message);
}*/
