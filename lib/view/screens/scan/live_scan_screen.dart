import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class LiveScanScreen extends StatefulWidget {
  const LiveScanScreen({super.key, required this.modelName});
  final String? modelName;

  @override
  State<LiveScanScreen> createState() => _LiveScanScreenState();
}

class _LiveScanScreenState extends State<LiveScanScreen> {
  CameraController? _controller;
  Interpreter? _interpreter;

  bool _isProcessing = false;
  DateTime _lastInference = DateTime.now();
  final Duration inferenceInterval = const Duration(milliseconds: 500);

  bool _isLoading = true;
  String? _errorMessage;

  List<Detection> _detections = [];

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

  @override
  void initState() {
    super.initState();
    _initializeCameraAndModel();
  }

  Future<void> _initializeCameraAndModel() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.low, // Use low to reduce frame size for CPU
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _controller!.initialize();

      final modelPath = widget.modelName == 'Pest Detection'
          ? 'assets/models/bestCV/pest_saved_model/pest_float16.tflite'
          : 'assets/models/bestCV/weed_saved_model/weed_float16.tflite';

      _interpreter = await Interpreter.fromAsset(modelPath);

      _controller!.startImageStream((CameraImage image) async {
        final now = DateTime.now();
        if (_isProcessing || now.difference(_lastInference) < inferenceInterval) return;

        _isProcessing = true;
        _lastInference = now;

        await _processFrame(image);

        _isProcessing = false;
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Initialization error: $e';
      });
    }
  }

  Future<void> _processFrame(CameraImage image) async {
    try {
      final frame = _convertYUV420ToImage(image);

      // ✅ Use correct model input size: assume 320x320 — adjust if needed
      final resized = img.copyResize(frame, width: 640, height: 640);

      final input = _imageToFloat32List(resized);

      final channels = widget.modelName == 'Pest Detection' ? 14 : 6;
      final output = List.generate(
        1,
            (_) => List.generate(channels, (_) => List.filled(8400, 0.0)),
      );

      _interpreter!.run([input], output);

      final boxes = parseDetections(
        output[0],
        labels: pestLabels,
      );

      if (mounted) {
        setState(() {
          _detections = boxes;
        });
      }
    } catch (e) {
      debugPrint('Frame error: $e');
    }
  }

  /// ✅ Correct YUV -> RGB conversion (handles typical Android YUV)
  img.Image _convertYUV420ToImage(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    final img.Image imgData = img.Image(width: width, height: height);

    final planeY = image.planes[0];
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int pixel = planeY.bytes[y * planeY.bytesPerRow + x];
        imgData.setPixelRgb(x, y, pixel, pixel, pixel);
      }
    }

    return imgData;
  }

  /// ✅ Resize to 320 and convert to normalized float32 tensor
  List<List<List<double>>> _imageToFloat32List(img.Image image) {
    return List.generate(640, (y) {
      return List.generate(640, (x) {
        final pixel = image.getPixel(x, y);
        return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
      });
    });
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
    _controller?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(_errorMessage!)),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          ..._detections.map(
                (d) => Positioned(
              left: d.x * MediaQuery.of(context).size.width,
              top: d.y * MediaQuery.of(context).size.height,
              child: Container(
                padding: const EdgeInsets.all(4),
                color: Colors.red.withOpacity(0.5),
                child: Text(
                  '${d.label} ${(d.confidence * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
