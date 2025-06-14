// Relevant imports
import 'dart:io';
import 'dart:typed_data';
import 'package:final_project/model/plant_disease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../view_model/utils/app_colors/app_colors.dart';
import '../../../view_model/utils/Texts/Texts.dart';

class ImageScanScreen extends StatefulWidget {
  final File imageFile;
  final String modelName;

  const ImageScanScreen({
    super.key,
    required this.imageFile,
    required this.modelName,
  });

  @override
  State<ImageScanScreen> createState() => _ImageScanScreen();
}

class _ImageScanScreen extends State<ImageScanScreen> {
  late Interpreter _interpreter;
  bool _isLoading = true;
  late img.Image _originalImage;
  late img.Image _resizedImage;
  List<Detection> _detections = [];
  String? _classificationResult;
  bool healthy = false;

  final List<String> pestLabels = [
    'grasshoppers',
    'butterfly',
    'cicada',
    'dragonfly',
    'spider',
    'snail',
    'scorpion',
    'bees',
    'moth',
    'beetle',
  ];

  final List<String> plantVillageLabels = DiseaseData.plantNames;
  final List<String> diseases = DiseaseData.diseaseNames;
  final List<List<Map<String, String>>> treatments =
      DiseaseData.treatmentsWithAdvice;

  @override
  void initState() {
    super.initState();
    _loadModelAndRunInference();
  }

  Future<void> _loadModelAndRunInference() async {
    try {
      final modelPath = widget.modelName == 'Pest Detection'
          ? 'assets/models/bestCV/pest_saved_model/pest_float16.tflite'
          : widget.modelName == 'Weed Detection'
              ? 'assets/models/bestCV/weed_saved_model/weed_float16.tflite'
              : 'assets/models/plantvillage/Plant_Village_Detection_Model.tflite';

      _interpreter = await Interpreter.fromAsset(modelPath);

      final imageBytes = await widget.imageFile.readAsBytes();
      _originalImage = img.decodeImage(imageBytes)!;

      if (widget.modelName == 'Plant Disease') {
        _resizedImage = img.copyResize(_originalImage, width: 224, height: 224);
        final input = _imageToFloat32ListForClassification(_resizedImage);
        var output = List.filled(33, 0.0).reshape([1, 33]);
        _interpreter.run(input, output);

        final scores = output[0];
        double maxScore = -1;
        int maxIndex = -1;
        for (int i = 0; i < scores.length; i++) {
          if (scores[i] > maxScore) {
            maxScore = scores[i];
            maxIndex = i;
          }
        }

        setState(() {
          _classificationResult =
              '${plantVillageLabels[maxIndex]} - ${diseases[maxIndex]}';
          if (diseases[maxIndex] == 'Healthy') healthy = true;
          _isLoading = false;
        });
      } else {
        _resizedImage = img.copyResize(_originalImage, width: 640, height: 640);
        final input = _imageToFloat32ListForDetection(_resizedImage);
        final channels = widget.modelName == 'Pest Detection' ? 14 : 6;
        final output = List.generate(
            1, (_) => List.generate(channels, (_) => List.filled(8400, 0.0)));
        _interpreter.run([input], output);
        final boxes = parseDetections(output[0], labels: pestLabels);
        setState(() {
          _detections = boxes;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error during inference: $e');
      setState(() => _isLoading = false);
    }
  }

  List<List<List<double>>> _imageToFloat32ListForDetection(img.Image image) {
    return List.generate(640, (y) {
      return List.generate(640, (x) {
        final pixel = image.getPixel(x, y);
        return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
      });
    });
  }

  List<List<List<List<double>>>> _imageToFloat32ListForClassification(
      img.Image image) {
    return [
      List.generate(224, (y) {
        return List.generate(224, (x) {
          final pixel = image.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        });
      }),
    ];
  }

  List<Detection> parseDetections(List<List<double>> output,
      {double threshold = 0.7, required List<String> labels}) {
    List<Detection> results = [];

    int numClasses = output.length - 4;
    int numBoxes = output[0].length;

    for (int i = 0; i < numBoxes; i++) {
      double x = output[0][i];
      double y = output[1][i];
      double w = output[2][i];
      double h = output[3][i];

      List<double> classProbs = [];
      for (int c = 0; c < numClasses; c++) {
        classProbs.add(output[4 + c][i]);
      }

      double maxProb = classProbs.reduce((a, b) => a > b ? a : b);
      int classIndex = classProbs.indexOf(maxProb);

      if (maxProb > threshold) {
        results.add(Detection(
          x: x,
          y: y,
          w: w,
          h: h,
          label: labels[classIndex],
          confidence: maxProb,
        ));
      }
    }

    return results;
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBody14(widget.modelName,
            color: AppColors.white, fontSize: 18.sp),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                SizedBox(height: 20.h),
                const Center(child: TextBody14('Original Image')),
                SizedBox(height: 12.h),
                Image.file(widget.imageFile),
                SizedBox(height: 12.h),
                if (_classificationResult != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: TextBody14(
                          healthy ? 'Healthy' : 'Detected Disease',
                          color: healthy ? Colors.green : Colors.black,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Center(
                        child: Text(
                          _classificationResult!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: healthy ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Visibility(
                        visible: !healthy,
                        child: Column(
                          children: [
                            const Center(
                                child: TextBody14('Treatment Steps & Advice')),
                            SizedBox(height: 12.h),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: treatments[plantVillageLabels.indexOf(
                                      _classificationResult!.split(' - ')[0])]
                                  .length,
                              itemBuilder: (context, index) {
                                final treatment = treatments[plantVillageLabels
                                    .indexOf(_classificationResult!
                                        .split(' - ')[0])][index];

                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 12.w),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          treatment['step'] ?? '',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          treatment['advice'] ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[700],
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Column(
                    children: [
                      const Center(child: TextBody14('Detection Results')),
                      SizedBox(height: 12.h),
                      FittedBox(
                        child: InteractiveViewer(
                          child: Stack(
                            children: [
                              Image.memory(
                                Uint8List.fromList(
                                    img.encodeJpg(_resizedImage)),
                              ),
                              ..._detections.map((d) => Positioned(
                                    left: (d.x - d.w / 2) * 640,
                                    top: (d.y - d.h / 2) * 640,
                                    width: d.w * 640,
                                    height: d.h * 640,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red, width: 2),
                                      ),
                                      child: widget.modelName=='Pest Detection' ?  Text(
                                        '${d.label} ${(d.confidence * 100).toStringAsFixed(1)}%',
                                        style: const TextStyle(
                                          backgroundColor: Colors.red,
                                          color: Colors.white,
                                        ),
                                      ):Text(
                                        'ridderzuring ${(d.confidence * 100).toStringAsFixed(1)}%',
                                        style: const TextStyle(
                                          backgroundColor: Colors.red,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                    ],
                  ),
              ],
            ),
    );
  }
}

// Detection model
class Detection {
  final double x;
  final double y;
  final double w;
  final double h;
  final String label;
  final double confidence;

  Detection({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.label,
    required this.confidence,
  });
}
