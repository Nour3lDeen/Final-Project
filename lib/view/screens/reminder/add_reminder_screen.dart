/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/reminder/plant.dart';
import '../../../model/reminder/plant_reminder.dart';
import '../../../view_model/cubits/reminder/reminder_cubit.dart';

class AddReminderScreen extends StatelessWidget {
  const AddReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReminderCubit>();
    Plant? selectedPlant;
    TimeOfDay selectedTime = TimeOfDay.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Watering Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<Plant>(
              value: selectedPlant,
              hint: const Text('Select a plant'),
              items: plantsDataset.map((plant) {
                return DropdownMenuItem(
                  value: plant,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plant.name),
                      Text(
                        'Water every ${plant.wateringFrequencyDays} days',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (plant) => selectedPlant = plant,
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Reminder Time'),
              subtitle: Text(selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (time != null) selectedTime = time;
              },
            ),
            if (selectedPlant != null) ...[
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Care Tips for ${selectedPlant!.name}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(selectedPlant!.careTips),
                    ],
                  ),
                ),
              ),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedPlant == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a plant')),
                  );
                  return;
                }

                final reminder = PlantReminder(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  plant: selectedPlant!,
                  time: selectedTime,
                );

                cubit.addReminder(reminder);
                Navigator.pop(context);
              },
              child: const Text('Save Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}*/
