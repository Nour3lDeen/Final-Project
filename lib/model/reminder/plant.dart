class Plant {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final int wateringFrequencyDays;
  final String careTips;

  const Plant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.wateringFrequencyDays,
    required this.careTips,
  });
}

final List<Plant> plantsDataset = [
  const Plant(
    id: '1',
    name: 'Snake Plant',
    imageUrl: 'assets/plants/snake_plant.jpg',
    description: 'Hardy indoor plant that purifies air',
    wateringFrequencyDays: 14, // Every 2 weeks
    careTips: 'Water sparingly. Allow soil to dry between waterings.',
  ),
  const Plant(
    id: '2',
    name: 'Peace Lily',
    imageUrl: 'assets/plants/peace_lily.jpg',
    description: 'Beautiful flowering plant that thrives in shade',
    wateringFrequencyDays: 7, // Weekly
    careTips: 'Keep soil moist. Prefers indirect light.',
  ),
  const Plant(
    id: '3',
    name: 'Spider Plant',
    imageUrl: 'assets/plants/spider_plant.jpg',
    description: 'Easy to grow with arching leaves',
    wateringFrequencyDays: 7, // Weekly
    careTips: 'Water when top inch of soil is dry. Produces baby plants.',
  ),
  const Plant(
    id: '4',
    name: 'Aloe Vera',
    imageUrl: 'assets/plants/aloe_vera.jpg',
    description: 'Medicinal succulent with thick leaves',
    wateringFrequencyDays: 21, // Every 3 weeks
    careTips: 'Water deeply but infrequently. Needs bright light.',
  ),
  const Plant(
    id: '5',
    name: 'English Ivy',
    imageUrl: 'assets/plants/english_ivy.jpg',
    description: 'Trailing vine that purifies air',
    wateringFrequencyDays: 7, // Weekly
    careTips: 'Keep soil moist. Prefers cooler temperatures.',
  ),
  const Plant(
    id: '6',
    name: 'ZZ Plant',
    imageUrl: 'assets/plants/zz_plant.jpg',
    description: 'Tough plant with glossy leaves',
    wateringFrequencyDays: 21, // Every 3 weeks
    careTips: 'Drought tolerant. Water when soil is completely dry.',
  ),
  const Plant(
    id: '7',
    name: 'Pothos',
    imageUrl: 'assets/plants/pothos.jpg',
    description: 'Fast-growing trailing vine',
    wateringFrequencyDays: 7, // Weekly
    careTips: 'Water when soil feels dry. Tolerates low light.',
  ),
  const Plant(
    id: '8',
    name: 'Rubber Plant',
    imageUrl: 'assets/plants/rubber_plant.jpg',
    description: 'Sturdy plant with large, dark leaves',
    wateringFrequencyDays: 7, // Weekly in summer, 14 in winter
    careTips: 'Wipe leaves to keep clean. Prefers bright, indirect light.',
  ),
  const Plant(
    id: '9',
    name: 'Cactus',
    imageUrl: 'assets/plants/cactus.jpg',
    description: 'Desert plant with minimal water needs',
    wateringFrequencyDays: 30, // Monthly
    careTips: 'Water sparingly. Needs plenty of sunlight.',
  ),
  const Plant(
    id: '10',
    name: 'Fiddle Leaf Fig',
    imageUrl: 'assets/plants/fiddle_leaf.jpg',
    description: 'Trendy plant with large violin-shaped leaves',
    wateringFrequencyDays: 7, // Weekly
    careTips: 'Keep away from drafts. Rotate for even growth.',
  ),
];