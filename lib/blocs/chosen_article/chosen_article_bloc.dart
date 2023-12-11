import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_event.dart';
import 'package:kindsbi_test/blocs/chosen_article/chosen_article_state.dart';

StreamController<List> controller = StreamController();

class ChosenArticleBloc extends Bloc<ChosenArticleEvent, ChosenAState> {
  ChosenArticleBloc() : super(ChosenArticleState(article: ' ', header: ' ')) {
    on<LoadArticle>((event, emit) async {
      final Map article = await fetchArticle(event.loadArticle);

      emit(ChosenArticleState(
          article: article['article'], header: article['header']));
    });

    on<CleanChosenArticle>((event, emit) async {
      emit(ChosenArticleState(article: ' ', header: ' '));
    });
  }
}

Future<Map> fetchArticle(String urlArticle) async {
  final url = Uri.parse(urlArticle);
  final response = await http.get(url);

  Map generalResult = {};

  BeautifulSoup bs = BeautifulSoup(response.body);
  String? res_1 = bs.find('p', class_: 'css-at9mc1 evys1bk0')?.text;
  String? res_2 =
      bs.find('p', class_: 'css-at9mc1 evys1bk0')?.nextSibling?.text;
  String? res_3 = bs
      .find('p', class_: 'css-at9mc1 evys1bk0')
      ?.nextSibling
      ?.nextSibling
      ?.text;

  String article = '$res_1 $res_2 $res_3';
  generalResult['article'] = article;

  String? header = bs.find('h1')?.text;
  generalResult['header'] = header;

  if (response.statusCode == 200) {
    return generalResult;
  } else {
    throw Exception('Failed to fetch articles');
  }
}
