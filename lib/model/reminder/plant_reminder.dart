import 'package:final_project/model/reminder/plant.dart';
import 'package:flutter/material.dart';

class PlantReminder {
  final String id;
  final Plant plant;
  final TimeOfDay time;
  final bool isActive;

  PlantReminder({
    required this.id,
    required this.plant,
    required this.time,
    this.isActive = true,
  });

  int get frequencyDays => plant.wateringFrequencyDays;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantId': plant.id,
      'hour': time.hour,
      'minute': time.minute,
      'isActive': isActive,
    };
  }

  factory PlantReminder.fromMap(Map<String, dynamic> map) {
    final plant = plantsDataset.firstWhere((p) => p.id == map['plantId']);
    return PlantReminder(
      id: map['id'],
      plant: plant,
      time: TimeOfDay(hour: map['hour'], minute: map['minute']),
      isActive: map['isActive'],
    );
  }
}