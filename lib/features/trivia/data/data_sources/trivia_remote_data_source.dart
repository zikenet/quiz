import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:quiz/core/error/exception.dart';
import 'package:quiz/features/trivia/data/models/trivia_model.dart';

abstract class TriviaRemoteDataSource {
  /// Calls the http://opentdb.com/api.php?amount=100&category=category&difficulty=difficulty
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TriviaModel> getConcreteTrivia(
      int category, String difficulty, int amount);
}

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  final Dio dio;

  TriviaRemoteDataSourceImpl({required this.dio}) {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15000),
      receiveTimeout: const Duration(seconds: 15000),
      headers: {
        "Content-type": "application/json",
      },
      responseType: ResponseType.plain,
    );
  }
  @override
  Future<TriviaModel> getConcreteTrivia(
    int category,
    String difficulty,
    int amount,
  ) async {
    Response response;
    try {
      response = await dio.get(
        'https://opentdb.com/api.php',
        queryParameters: {
          'amount': amount,
          'category': category,
          'difficulty': difficulty,
        },
      );
      final result = jsonDecode(response.data);

      if (response.statusCode == 200 && result['response_code'] == 0) {
        return TriviaModel.fromJson(result);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
}
