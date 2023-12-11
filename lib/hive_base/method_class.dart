import 'package:hive_flutter/hive_flutter.dart';

class HiveMethods {
  String hiveBox = 'hive_local_db';

  addArticleToHive(String header, String article) async {
    var box = await Hive.openBox(hiveBox);

    await box.put(header, article);
  }

  deleteArticleFromHive(String header) async {
    var box = await Hive.openBox(hiveBox);
    if (box.isNotEmpty) {
      await box.delete(header);
    }
  }
}
//