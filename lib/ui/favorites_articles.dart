import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindsbi_test/utilites/botton_nav_bar.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bookmarks',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Saved articles to the library',
                      style: TextStyle(fontSize: 19),
                    )),
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: Hive.box('hive_local_db').listenable(),
                    builder: (context, box, widget) {
                      return box.values.isEmpty
                          ? const Center(
                              child:
                                  Text('Вы пока не сохранили ни одной статьи'),
                            )
                          : ListView.builder(
                              itemCount: box.values.length,
                              itemBuilder: (BuildContext context, int index) {
                                String key = box.keyAt(index);

                                return ListTile(
                                  leading: Container(
                                    child: Image.asset(
                                        "assets/images/image-3.jpg",
                                        fit: BoxFit.fill),
                                  ),
                                  title: Text(key),
                                );
                              },
                            );
                    }),
              )
            ]),
          ),
          bottomNavigationBar: const BottomNavBar()),
    );
  }
}
