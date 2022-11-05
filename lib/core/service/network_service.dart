import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_firestore/core/failures/connection_failure.dart';
import 'package:todo_firestore/core/failures/failure.dart';
import 'package:todo_firestore/core/failures/server_failure.dart';
import 'package:todo_firestore/core/failures/unknown_failure.dart';
import 'package:todo_firestore/core/failures/url_format_failure.dart';

@injectable
class NetworkService {
  final InternetConnectionChecker connectionChecker;

  NetworkService({required this.connectionChecker});

  final client = http.Client();

  Future<Either<Failure, dynamic>> request({
    required String url,
    required Map<String, dynamic> parameters,
  }) async {
    final isConnected = await connectionChecker.hasConnection;
    if (!isConnected) {
      return Left(ConnectionFailure());
    }

    String urlWithParameters = url;

    for (var i = 0; i < parameters.keys.length; i++) {
      final key = parameters.keys.toList()[i];
      final value = '${parameters[key]}';
      if (i == 0) {
        urlWithParameters += '?$key=$value';
      } else {
        urlWithParameters += '&$key=$value';
      }
    }

    final uri = Uri.tryParse(urlWithParameters);
    if (uri == null) {
      return Left(UrlFormatFailure());
    }

    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return Right(json.decode(response.body));
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
