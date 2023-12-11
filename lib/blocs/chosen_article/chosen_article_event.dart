abstract class ChosenArticleEvent {}

class LoadArticle extends ChosenArticleEvent {

  late String loadArticle;

  LoadArticle(this.loadArticle);

}

class CleanChosenArticle extends ChosenArticleEvent {}

