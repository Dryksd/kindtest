import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindsbi_test/local_notification.dart';
import 'package:kindsbi_test/preparation_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('hive_local_db');
  await LocalNoticeService().setup();
  await dotenv.load(
fileName:  'assets/.env'
  );
  runApp( PreparePage());
}




