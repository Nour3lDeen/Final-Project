import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/view_model/utils/data/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedHelper.init();
  await dotenv.load();

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY']!,);
  runApp(const MyApp());
}
