import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_bloc.dart';
import 'package:kindsbi_test/blocs/get_data_fromserver/get_data_fromserver_bloc.dart';
import 'package:kindsbi_test/blocs/get_data_fromserver/get_data_fromserver_event.dart';
import 'package:kindsbi_test/routes_ones.dart';

class PreparePage extends StatelessWidget {
  PreparePage({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ArticlesBloc()..add(LoadNews())),
          BlocProvider(create: (_) => ChosenArticleBloc()),
        ],
        child: MaterialApp.router(
            title: 'MAgro',
            debugShowCheckedModeBanner: false,
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate()) //;

        );
  }
}
