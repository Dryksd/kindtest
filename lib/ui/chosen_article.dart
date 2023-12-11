import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_bloc.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_event.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_state.dart';
import 'package:kindsbi_test/hive_base/method_class.dart';

@RoutePage()
class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChosenArticleBloc, ChosenAState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.router.back();
              context.read<ChosenArticleBloc>().add(CleanChosenArticle());
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                HiveMethods().addArticleToHive(state.header, state.article);
              },
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ],
          title: const Text('Название категории'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        body: state.header == ' '
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      state.header,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      state.article,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )),
      );
    });
  }
}
