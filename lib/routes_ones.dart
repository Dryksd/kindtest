import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:kindsbi_test/local_notification.dart';
import 'package:kindsbi_test/ui/chosen_article.dart';
import 'package:kindsbi_test/ui/favorites_articles.dart';
import 'package:kindsbi_test/ui/homepage.dart';


part 'routes_ones.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    //AutoRoute(page: CounterViewRoute.page, initial: true, path: '/'),

    AutoRoute(page: FavoritesRoute.page, path: '/favorites'),
    AutoRoute(page: ArticleRoute.page, path: '/chosen_article'),
    AutoRoute(page: HomeRoute.page, initial: true, path: '/'),

  ];
}