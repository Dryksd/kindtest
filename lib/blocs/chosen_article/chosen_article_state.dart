import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ChosenAState extends Equatable {
  late final String article;
  late final String header;
}

class ChosenArticleState extends ChosenAState {
  ChosenArticleState({required this.article, required this.header});

  @override
  final String article;

  @override
  final String header;

  @override
  List<Object> get props => [article];
}
