import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:kindsbi_test/blocs/get_data_fromserver/get_data_fromserver_event.dart';
import 'package:kindsbi_test/blocs/get_data_fromserver/get_data_fromserver_state.dart';
import 'package:kindsbi_test/local_notification.dart';
import 'package:kindsbi_test/models/news_model_class.dart';

StreamController urlNewArticle = StreamController.broadcast();

class ArticlesBloc extends Bloc<UsersEvent, AuthState> {
  ArticlesBloc() : super(UsersState(users: const [], currentIndex: 0)) {
    on<LoadNews>((event, emit) async {
      final List articles = await fetchArticles();
      final List<Article> parsedArticles = parseArticles(articles);

      Timer.periodic(const Duration(seconds: 30), (timer) {
        checkArticles(parsedArticles);
      });

      emit(ArticlesState(users: parsedArticles));
    });
  }
}

Future<List<dynamic>> fetchArticles() async {
  final apiKey = dotenv.env['API_KEY'];
  final url = Uri.parse(
      //'https://api.nytimes.com/svc/topstories/v2/technology.json?api-key=$apiKey');
      'https://api.nytimes.com/svc/topstories/v2/home.json?api-key=$apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to fetch articles');
  }
}

List<Article> parseArticles(List<dynamic> articlesData) {
  return articlesData.map((articleData) {
    return Article(
      title: articleData['title'],
      abstract: articleData['abstract'],
      section: articleData['section'],
      url: articleData['url'],
      byline: articleData['byline'],
      publishedDate: articleData['published_date'],
    );
  }).toList();
}

void checkArticles(List data) async {
  if (data.isNotEmpty) {
    final List articles = await fetchArticles();
    final List<Article> parsedArticles = parseArticles(articles);
    if (parsedArticles.length > data.length) {
      BlocListener<ArticlesBloc, AuthState>(listener: (context, state) {
        context.read<ArticlesBloc>().add(LoadNews());
      });

      urlNewArticle.add(parsedArticles.first.url);
      newsNotification();
    } else {
      //newsNotification();

      //urlNewArticle.add(parsedArticles.first.url);
    }
  }
}

void newsNotification() {
  LocalNoticeService()
      .showLocalNotification('There is new article!', 'news news news');
}
