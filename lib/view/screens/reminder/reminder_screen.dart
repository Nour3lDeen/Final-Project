/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/cubits/reminder/reminder_cubit.dart';
import 'add_reminder_screen.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watering Reminders')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddReminderScreen(
                ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ReminderCubit, ReminderState>(
        builder: (context, state) {
          if (state is RemindersLoaded) {
            return ListView.builder(
              itemCount: state.reminders.length,
              itemBuilder: (context, index) {
                final reminder = state.reminders[index];
                final cubit = context.read<ReminderCubit>();
                return ListTile(
                  leading: Image.asset(
                    reminder.plant.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(reminder.plant.name),
                  subtitle: Text(
                    'Water every ${reminder.frequencyDays} days at ${reminder.time.format(context)}',
                  ),
                  trailing: Switch(
                    value: reminder.isActive,
                    onChanged: (_) => cubit.toggleReminder(reminder.id),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}*/
