class PlantDisease {
  final String name;
  final String plant;
  final List<Map<String, String>> treatments;

  PlantDisease({
    required this.name,
    required this.plant,
    required this.treatments,
  });
}

class DiseaseData {
  static final List<String> diseaseNames = [
    'Apple Scab', 'Black Rot', 'Cedar Apple Rust', 'Healthy', 'Powdery Mildew',
    'Healthy', 'Cercospora Leaf Spot OR Gray Leaf Spot', 'Common Rust', 'Northern Leaf Blight',
    'Healthy', 'Black Rot', 'Esca (Black Measles)', 'Leaf Blight (Isariopsis Leaf Spot)', 'Healthy',
    'Bacterial Spot', 'Healthy', 'Bacterial Spot', 'Healthy', 'Early Blight', 'Late Blight', 'Healthy',
    'Leaf Scorch', 'Healthy', 'Bacterial Spot', 'Early Blight', 'Late Blight',
    'Leaf Mold', 'Septoria Leaf Spot', 'Spider Mites OR Two Spotted Spider Mite', 'Target Spot',
    'Tomato Yellow Leaf Curl Virus', 'Tomato Mosaic Virus', 'Healthy'
  ];

  static final List<String> plantNames = [
    'Apple', 'Apple', 'Apple', 'Apple',
    'Cherry (including Sour)', 'Cherry (including Sour)',
    'Corn (maize)', 'Corn (maize)', 'Corn (maize)', 'Corn (maize)',
    'Grape', 'Grape', 'Grape', 'Grape',
    'Peach', 'Peach',
    'Pepper', 'Pepper',
    'Potato', 'Potato', 'Potato',
    'Strawberry', 'Strawberry',
    'Tomato', 'Tomato', 'Tomato', 'Tomato', 'Tomato', 'Tomato', 'Tomato', 'Tomato', 'Tomato', 'Tomato'
  ];

  static final List<List<Map<String, String>>> treatmentsWithAdvice = [
    //Apple___Apple_scab
    [
    {'step': 'Step 1: Apply fungicides such as sulfur or copper-based fungicides. Repeat application every 7-10 days during the growing season.',
      'advice': "Make sure to follow the manufacturer's instructions for the correct dosage and application methods. Overuse of fungicides can lead to resistance."},
    {'step': 'Step 2: Prune affected areas and remove fallen leaves to reduce infection. Always use sterilized pruning tools to prevent the spread of spores.',
      'advice': 'Be cautious when pruning. If the disease is widespread, pruning can sometimes spread it further. Always disinfect pruning tools after use.'},
    {'step': 'Step 3: Increase air circulation around the tree by thinning branches. This will help reduce humidity levels, making it less favorable for the growth of the disease.',
      'advice': 'Proper spacing and airflow can reduce the overall humidity around the plant, discouraging the growth of fungal infections.'},
    {'step': 'Step 4: In the fall, rake and remove fallen leaves, as these can harbor fungal spores over winter.',
      'advice': 'Do not compost the infected leaves; dispose of them in a sealed bag to prevent the spores from spreading.'}
  ],
  // Apple___Black_rot
  [
  {'step': 'Step 1: Use copper-based fungicides immediately after symptom appearance. Apply fungicide every 7-14 days until harvest. Avoid applying during rainfall to prevent washing off.',
  'advice': 'Be sure to reapply fungicide after heavy rains, as it can wash off and lose effectiveness.'},
  {'step': 'Step 2: Prune infected branches and dispose of them to avoid spreading the disease to healthy parts of the tree.',
  'advice': 'Always wear gloves and sterilize your pruning tools to avoid contaminating healthy plants.'},
  {'step': 'Step 3: Remove infected fruit and leaves from the ground to prevent re-infection next season.',
  'advice': "Don't leave infected plant debris on the soil surface, as it can reintroduce the disease in the future."},
  {'step': 'Step 4: Ensure your orchard has good drainage to prevent excess moisture around the tree base, which can foster the growth of black rot.',
  'advice': 'Soil drainage is essential in preventing fungal diseases. Consider adding organic matter or improving the soil structure to help with drainage.'}
  ],
  // Apple___Cedar_apple_rust
  [
  {'step': 'Step 1: Apply fungicides like propiconazole or tebuconazole during the growing season. Start spraying when the buds begin to swell in the spring and reapply every 10-14 days.',
  'advice': 'If possible, apply the fungicide in the early morning or late afternoon to avoid burn marks on the leaves during hot weather.'},
  {'step': 'Step 2: Prune infected branches and dispose of them properly. Make sure to wear gloves when handling infected material to avoid spreading spores.',
  'advice': 'Avoid pruning during wet weather to prevent spreading the spores to other parts of the tree.'},
  {'step': 'Step 3: Plant resistant varieties to avoid the disease in the future. Consider hybrid varieties with resistance to cedar apple rust.',
  'advice': 'Planting resistant varieties can significantly reduce the need for chemical interventions, which is environmentally friendly.'},
  {'step': 'Step 4: Clean up fallen leaves from under the tree, as these can harbor the disease over winter and lead to reinfection next spring.',
  'advice': 'Be sure to destroy the fallen leaves instead of composting them, as composting can allow the spores to survive.'}
  ],
  // Apple___healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Cherry_(including_sour)_Powdery_mildew
  [
  {'step': 'Step 1: Apply fungicides like sulfur, neem oil, or potassium bicarbonate at the first sign of powdery mildew. Repeat every 7-10 days during the growing season.',
  'advice': 'Ensure complete coverage of the affected areas with fungicide. If you miss a spot, the disease could persist.'},
  {'step': 'Step 2: Prune infected leaves to increase air circulation in the canopy. This will help reduce humidity, which the powdery mildew thrives on.',
  'advice': 'Pruning is a preventive measure, but avoid excessive pruning, as it can weaken the plant and create stress.'},
  {'step': 'Step 3: Ensure good air circulation by thinning infected leaves and branches. Avoid overcrowding plants.',
  'advice': 'When you plant, leave adequate space between plants to improve air flow. Overcrowding plants can lead to an environment where mildew thrives.'},
  {'step': 'Step 4: Remove and destroy fallen infected leaves in autumn. This will prevent overwintering of the disease.',
  'advice': 'Fallen leaves should be disposed of properly to avoid any potential reinfection the following season.'}
  ],
  // Cherry_(including_sour)_healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Corn_(maize)_Cercospora_leaf_spot Gray_leaf_spot
  [
  {'step': 'Step 1: Apply fungicides containing chlorothalonil or mancozeb every 7-10 days during active growth. Ensure complete coverage of the plants.',
  'advice': 'Be mindful of the weather when applying fungicides. Avoid applying during windy or rainy conditions.'},
  {'step': 'Step 2: Remove and destroy infected leaves to reduce the spread. Do this regularly to minimize the number of spores.',
  'advice': 'Inspect your plants frequently to catch any early signs of disease. Early removal helps prevent further spread.'},
  {'step': 'Step 3: Rotate crops to reduce the risk of future infections. Plant corn or other susceptible crops in a different field the next season.',
  'advice': 'Crop rotation is an excellent strategy for reducing the buildup of soil-borne pathogens.'},
  {'step': 'Step 4: Improve field drainage and reduce excess moisture in the soil, which can increase the chance of infection.',
  'advice': 'Consider installing drainage systems if you have heavy clay soil. Excess moisture can promote fungal infections.'}
  ],
  // Corn_(maize)Common_rust
  [
  {'step': 'Step 1: Apply fungicides containing triazoles like propiconazole or tebuconazole at the early stages of disease. Reapply every 10-14 days.',
  'advice': 'Apply fungicides in the morning or late afternoon to prevent leaf burn during hot weather.'},
  {'step': 'Step 2: Remove and dispose of infected leaves promptly.',
  'advice': 'Be sure to destroy the infected leaves and avoid leaving them on the field to prevent the spread of the disease.'},
  {'step': 'Step 3: Consider planting resistant corn varieties to reduce the risk of infection.',
  'advice': 'Choosing disease-resistant varieties helps minimize the need for frequent chemical treatments.'},
  {'step': 'Step 4: Rotate crops to reduce the presence of the disease in the soil for the following season.',
  'advice': 'By rotating crops, you break the disease cycle and reduce pathogen buildup.'}
  ],
  // Corn_(maize)_Northern_Leaf_Blight
  [
  {'step': 'Step 1: Apply fungicides such as chlorothalonil or propiconazole at the first sign of disease. Reapply every 10-14 days during the growing season.',
  'advice': 'Make sure to cover all leaf surfaces to effectively protect the plant.'},
  {'step': 'Step 2: Prune and remove any infected leaves to reduce the spread of the disease.',
  'advice': 'Prune in dry weather to avoid spreading spores and always sanitize pruning tools.'},
  {'step': 'Step 3: Plant resistant varieties of maize to limit the future occurrence of the disease.',
  'advice': 'Resistant varieties are key to reducing the need for fungicides and minimizing crop loss.'},
  {'step': 'Step 4: Improve field drainage to prevent excess moisture that promotes disease development.',
  'advice': 'Consider installing proper irrigation and drainage systems to reduce soil moisture.'}
  ],
  // Corn_(maize)_healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Grape___Black_rot
  [
  {'step': 'Step 1: Apply copper-based fungicides at bud break and repeat every 7-14 days during the growing season. Apply after rain events to ensure thorough protection.',
  'advice': 'Rain can wash away fungicides, so always reapply after significant rainfall.'},
  {'step': 'Step 2: Remove affected leaves and fruit immediately. Disinfect your pruning tools with a bleach solution between cuts.',
  'advice': 'Use sharp pruning tools to avoid damaging the plant, which could create openings for disease to enter.'},
  {'step': 'Step 3: Ensure good air circulation around the vine by thinning out dense growth. Use vertical trellising systems to support vines.',
  'advice': 'Prune grapes properly to maintain structure and prevent overcrowding, which reduces disease pressure.'},
  {'step': 'Step 4: In late fall, rake up and destroy fallen leaves and fruit to eliminate sources of the fungal pathogen.',
  'advice': 'Dispose of infected material promptly. Do not leave infected debris on the vineyard floor.'}
  ],
  // Grape__Esca(Black_Measles)
  [
  {'step': 'Step 1: Remove and destroy infected vines and leaves immediately to prevent the spread of the disease.',
  'advice': 'Be sure to dispose of infected plant material far away from healthy plants to avoid re-infection.'},
  {'step': 'Step 2: Apply copper-based fungicides early in the season before symptoms appear.',
  'advice': 'Apply fungicides during the dormant season or at bud break for better prevention.'},
  {'step': 'Step 3: Avoid overhead irrigation as it increases moisture and favors fungal development.',
  'advice': 'Use drip irrigation or soaker hoses to reduce moisture on the plant foliage.'},
  {'step': 'Step 4: Remove infected wood and canes in the late winter or early spring.',
  'advice': 'Cut back the infected parts of the vine to improve airflow and reduce pathogen spread.'}
  ],
  // Grape__Leaf_blight(Isariopsis_Leaf_Spot)
  [
  {'step': 'Step 1: Apply fungicides containing chlorothalonil or mancozeb at the early sign of infection.',
  'advice': 'Spray on both sides of the leaves to ensure full coverage and protect healthy plant tissue.'},
  {'step': 'Step 2: Remove and dispose of any infected leaves and vines to limit the disease spread.',
  'advice': 'Be sure to collect and discard the leaves promptly in sealed bags to avoid contamination.'},
  {'step': 'Step 3: Prune the vines to improve airflow and reduce moisture retention on the leaves.',
  'advice': 'Prune during the dormant season to reduce stress on the plant and improve its resistance.'},
  {'step': 'Step 4: Use resistant grape varieties to reduce the frequency of outbreaks.',
  'advice': 'Resistant varieties are more tolerant to the disease and can help maintain a healthy vineyard.'}
  ],
  // Grape___healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Peach___Bacterial_spot
  [
  {'step': 'Step 1: Apply copper-based bactericides at early stages, preferably before rainfall. Reapply as needed, particularly after rain events.',
  'advice': 'Be cautious with bactericides; too much can damage the tree. Apply according to label directions.'},
  {'step': 'Step 2: Prune and remove infected branches and fruit. Always disinfect your pruning tools to prevent cross-contamination.',
  'advice': 'Always wear gloves when handling infected material. Disinfect your tools between each cut to avoid spreading the infection.'},
  {'step': 'Step 3: Avoid overhead irrigation, as wet leaves can spread the bacteria. Use drip irrigation to keep foliage dry.',
  'advice': 'Watering plants at the base prevents leaves from becoming wet, which reduces the risk of bacterial spread.'},
  {'step': 'Step 4: During dry conditions, monitor plants closely for early symptoms, as bacterial spot can spread quickly in humid conditions.',
  'advice': 'Regularly inspect plants for early signs of infection, as prompt action can help minimize damage.'}
  ],
  // Peach___healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Pepper,bell__Bacterial_spot
  [
  {'step': 'Step 1: Remove and destroy infected plant material, including leaves and fruit.',
  'advice': 'Ensure proper disposal of infected material by sealing it in bags and removing it far from the garden to prevent further contamination.'},
  {'step': 'Step 2: Apply copper-based bactericides or streptomycin to prevent further bacterial infections.',
  'advice': 'Apply during periods of high humidity or rain, as these conditions favor bacterial growth.'},
  {'step': 'Step 3: Avoid overhead irrigation to reduce moisture on leaves and fruit.',
  'advice': 'Switch to drip irrigation to keep water away from the plant foliage and reduce disease spread.'},
  {'step': 'Step 4: Improve air circulation around the plants by properly spacing them and pruning any overcrowded growth.',
  'advice': 'Adequate spacing reduces the chances of bacterial spread and encourages healthy plant growth.'}
  ],
  // Pepper,bell__healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Potato___Early_blight
  [
  {'step': 'Step 1: Apply fungicides containing chlorothalonil or mancozeb immediately after symptom appearance. Apply every 7-10 days until harvest.',
  'advice': 'Be careful not to overuse fungicides, as this can lead to resistance. Rotate fungicides to avoid resistance.'},
  {'step': 'Step 2: Remove and destroy infected leaves and tubers. Do not compost infected material as it can spread the disease.',
  'advice': 'Ensure you dispose of infected material in sealed bags. Composting can encourage the spread of disease.'},
  {'step': 'Step 3: Rotate crops with non-solanaceous plants (i.e., not tomatoes, peppers, etc.) to avoid the buildup of the pathogen in the soil.',
  'advice': 'Rotating crops helps break the life cycle of soil-borne pathogens.'},
  {'step': 'Step 4: Ensure good soil drainage to prevent standing water, which encourages fungal growth.',
  'advice': 'Improve soil drainage by adding organic matter to the soil if necessary.'}
  ],
  // Potato___Late_blight
  [
  {'step': 'Step 1: Remove and destroy infected plant material, including leaves, stems, and tubers.',
  'advice': 'Dispose of the infected material away from the garden to prevent spreading the disease.'},
  {'step': 'Step 2: Apply fungicides like chlorothalonil, mancozeb, or copper to control the blight.',
  'advice': 'Spray fungicides regularly, especially in wet, humid conditions where the disease thrives.'},
  {'step': 'Step 3: Ensure proper spacing between plants to improve airflow and reduce moisture buildup.',
  'advice': 'Spacing helps reduce fungal growth by allowing plants to dry out faster.'},
  {'step': 'Step 4: Rotate crops annually and avoid planting potatoes in the same spot each year.',
  'advice': 'Crop rotation breaks the disease cycle and reduces the risk of reinfection.'}
  ],
  // Potato___healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Strawberry___Leaf_scorch
  [
  {'step': 'Step 1: Remove and destroy infected vines and leaves immediately to prevent the spread of the disease.',
  'advice': 'Be sure to dispose of infected plant material far away from healthy plants to avoid re-infection.'},
  {'step': 'Step 2: Apply copper-based fungicides early in the season before symptoms appear.',
  'advice': 'Apply fungicides during the dormant season or at bud break for better prevention.'},
  {'step': 'Step 3: Avoid overhead irrigation as it increases moisture and favors fungal development.',
  'advice': 'Use drip irrigation or soaker hoses to reduce moisture on the plant foliage.'},
  {'step': 'Step 4: Remove infected wood and canes in the late winter or early spring.',
  'advice': 'Cut back the infected parts of the vine to improve airflow and reduce pathogen spread.'}
  ],
  // Strawberry___healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],
  // Tomato___Bacterial_spot
  [
  {'step': 'Step 1: Remove and destroy infected plant material, including leaves and fruit.',
  'advice': 'Dispose of infected material away from the garden to prevent further contamination.'},
  {'step': 'Step 2: Apply copper-based bactericides to control the spread.',
  'advice': 'Apply during periods of high humidity or rain, as these conditions favor bacterial growth.'},
  {'step': 'Step 3: Avoid overhead irrigation to reduce moisture on leaves.',
  'advice': 'Use drip irrigation to keep foliage dry and minimize bacterial spread.'},
  {'step': 'Step 4: Rotate crops annually and avoid planting tomatoes in the same location each year.',
  'advice': 'Crop rotation helps break the disease cycle and reduces the risk of reinfection.'}
  ],
  // Tomato___Early_blight
  [
  {'step': 'Step 1: Remove and destroy infected plant material, including leaves and fruit.',
  'advice': 'Dispose of infected material away from the garden to prevent further contamination.'},
  {'step': 'Step 2: Apply copper-based bactericides to control the spread.',
  'advice': 'Apply during periods of high humidity or rain, as these conditions favor bacterial growth.'},
  {'step': 'Step 3: Avoid overhead irrigation to reduce moisture on leaves.',
  'advice': 'Use drip irrigation to keep foliage dry and minimize bacterial spread.'},
  {'step': 'Step 4: Rotate crops annually and avoid planting tomatoes in the same location each year.',
  'advice': 'Crop rotation helps break the disease cycle and reduces the risk of reinfection.'}
  ],
  // Tomato___Late_blight
  [
  {'step': 'Step 1: Remove and destroy all infected plant parts immediately.',
  'advice': 'Prompt removal prevents the disease from spreading to healthy plants.'},
  {'step': 'Step 2: Apply fungicides like chlorothalonil or copper-based products.',
  'advice': 'Apply before infection or at the first sign of disease, especially during wet weather.'},
  {'step': 'Step 3: Avoid overhead watering to keep foliage dry.',
  'advice': 'Wet leaves are more susceptible to infection; use drip irrigation instead.'},
  {'step': 'Step 4: Practice crop rotation and avoid planting tomatoes near potatoes.',
  'advice': 'Both crops are susceptible to late blight; rotating reduces disease risk.'}
  ],
  // Tomato___Leaf_Mold
  [
  {'step': 'Step 1: Remove and destroy infected leaves to reduce disease spread.',
  'advice': 'Proper disposal of infected material helps prevent reinfection.'},
  {'step': 'Step 2: Increase air circulation by spacing plants appropriately.',
  'advice': 'Good airflow reduces humidity around plants, deterring mold growth.'},
  {'step': 'Step 3: Apply fungicides such as chlorothalonil or mancozeb.',
  'advice': 'Begin treatment at the first sign of mold and follow label instructions.'},
  {'step': 'Step 4: Avoid overhead watering to keep foliage dry.',
  'advice': 'Drip irrigation minimizes leaf wetness, reducing mold development.'}
  ],
  // Tomato___Septoria_leaf_spot
  [
  {'step': 'Step 1: Remove and destroy infected leaves promptly.',
  'advice': 'Early removal limits the spread of the disease.'},
  {'step': 'Step 2: Apply fungicides containing chlorothalonil or mancozeb.',
  'advice': 'Start applications when spots first appear and repeat as needed.'},
  {'step': 'Step 3: Ensure proper spacing between plants for air circulation.',
  'advice': 'Adequate spacing helps leaves dry quickly, reducing fungal growth.'},
  {'step': 'Step 4: Mulch around the base of plants to prevent soil splash.',
  'advice': 'Mulching reduces the chance of soil-borne spores reaching the foliage.'}
  ],
  // Tomato___Spider_mites Two-spotted_spider_mite
  [
  {'step': 'Step 1: Spray plants with a strong stream of water to dislodge mites.',
  'advice': 'Regular spraying can reduce mite populations significantly.'},
  {'step': 'Step 2: Apply insecticidal soap or neem oil to affected areas.',
  'advice': 'These treatments are effective against mites and safe for plants.'},
  {'step': 'Step 3: Introduce natural predators like ladybugs or predatory mites.',
  'advice': 'Biological control helps maintain mite populations at low levels.'},
  {'step': 'Step 4: Keep plants well-watered and reduce dust around them.',
  'advice': 'Healthy, dust-free plants are less attractive to spider mites.'}
  ],
  // Tomato___Target_Spot
  [
  {'step': 'Step 1: Remove and destroy infected leaves and plant debris.',
  'advice': 'Clearing debris reduces sources of infection for new plants.'},
  {'step': 'Step 2: Apply appropriate fungicides like chlorothalonil.',
  'advice': 'Begin treatment at the first sign of disease and follow label directions.'},
  {'step': 'Step 3: Ensure proper plant spacing to improve air circulation.',
  'advice': 'Good airflow helps leaves dry quickly, deterring fungal growth.'},
  {'step': 'Step 4: Rotate crops and avoid planting tomatoes in the same area each year.',
  'advice': 'Crop rotation helps prevent the buildup of pathogens in the soil.'}
  ],
  // Tomato___Tomato_Yellow_Leaf_Curl_Virus
  [
  {'step': 'Step 1: Remove and destroy infected plants immediately.',
  'advice': 'Prompt removal prevents the virus from spreading to healthy plants.'},
  {'step': 'Step 2: Control whitefly populations using insecticidal soaps or neem oil.',
  'advice': 'Reducing whiteflies minimizes the spread of the virus.'},
  {'step': 'Step 3: Use reflective mulches to deter whiteflies.',
  'advice': 'Reflective surfaces can confuse and repel whiteflies from plants.'},
  {'step': 'Step 4: Plant resistant tomato varieties when available.',
  'advice': 'Resistant varieties are less likely to be affected by the virus.'}
  ],
  // Tomato___Tomato_mosaic_virus
  [
  {'step': 'Step 1: Remove and destroy infected plants immediately to prevent the virus from spreading.',
  'advice': 'Do not compost infected plants, as the virus can survive and infect future crops.'},
  {'step': 'Step 2: Disinfect tools and hands regularly during handling of plants.',
  'advice': 'Use a 10% bleach solution or commercial disinfectant to clean tools between each use.'},
  {'step': 'Step 3: Control aphids and other insects that can spread the virus mechanically.',
  'advice': 'Use insecticidal soap or neem oil early in the season to limit vector populations.'},
  {'step': 'Step 4: Plant resistant tomato varieties and avoid tobacco use around plants.',
  'advice': 'The virus can be transferred by touch from tobacco products; always wash hands thoroughly if exposed.'}
  ],
  // Tomato___healthy
  [
  {'step': "It doesn't need treatment. It's in great health.💪❤‍🩹"}
  ],

  ];

  static List<PlantDisease> getDiseases() {
    List<PlantDisease> diseases = [];
    for (int i = 0; i < diseaseNames.length; i++) {
      diseases.add(PlantDisease(
        name: diseaseNames[i],
        plant: plantNames[i],
        treatments: treatmentsWithAdvice[i],
      ));
    }
    return diseases;
  }

  static PlantDisease? getDiseaseByName(String name) {
    final index = diseaseNames.indexWhere((disease) => disease == name);
    if (index != -1) {
      return PlantDisease(
        name: diseaseNames[index],
        plant: plantNames[index],
        treatments: treatmentsWithAdvice[index],
      );
    }
    return null;
  }
}