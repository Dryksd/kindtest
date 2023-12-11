import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_bloc.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_event.dart';
import 'package:kindsbi_test/blocs/get_data_fromserver/get_data_fromserver_bloc.dart';
import 'package:kindsbi_test/blocs/get_data_fromserver/get_data_fromserver_state.dart';
import 'package:kindsbi_test/local_notification.dart';
import 'package:kindsbi_test/utilites/botton_nav_bar.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var subscription1 = newArticleController.stream.listen((item) {
      if (item == true) {
        var subscription2 = urlNewArticle.stream.listen((item2) {
          context.read<ChosenArticleBloc>().add(LoadArticle(item2));
        });

        context.router.pushNamed('/chosen_article');
        newArticleController.add(false);
      }
    });

    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Browse',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Discover things of the world',
                        style: TextStyle(fontSize: 19),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          //borderSide: const BorderSide(width: 1.0,color: Colors.black12),
                          borderRadius: BorderRadius.circular(20.0)),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.keyboard_voice),
                      hintText: 'Поиск',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      ActionChip(
                          padding: EdgeInsets.all(8),
                          backgroundColor: Colors.blue,
                          disabledColor: Colors.blue,
                          label: Text('category')),
                      SizedBox(
                        width: 5,
                      ),
                      ActionChip(
                          disabledColor: Colors.blue, label: Text('category')),
                      SizedBox(
                        width: 5,
                      ),
                      ActionChip(
                          disabledColor: Colors.blue, label: Text('category')),
                      SizedBox(
                        width: 5,
                      ),
                      ActionChip(
                          disabledColor: Colors.blue, label: Text('category')),
                      SizedBox(
                        width: 5,
                      ),
                      ActionChip(
                          disabledColor: Colors.blue, label: Text('category')),
                      SizedBox(
                        width: 5,
                      ),
                      ActionChip(
                          disabledColor: Colors.blue, label: Text('category')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ArticlesBloc, AuthState>(builder: (context, state) {
                  return state.users.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (BuildContext context, int index) {
                              final article = state.users[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(0.0, 0.0),
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            "assets/images/image-8.jpg",
                                            fit: BoxFit.fill),
                                      ),
                                      ListTile(
                                        title: Column(
                                          children: [
                                            Container(
                                                child: TextButton(
                                              onPressed: () {
                                                context
                                                    .read<ChosenArticleBloc>()
                                                    .add(LoadArticle(
                                                        article.url));

                                                context.router.pushNamed(
                                                    '/chosen_article');
                                              },
                                              child: Text(
                                                article.title,
                                                style: const TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.black87),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                }),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavBar()),
    );
  }
}
