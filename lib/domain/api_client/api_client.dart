import 'dart:convert';
import 'dart:io';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '515c4a4fa81af931867cbb224bbb3445';

  static String imageUrl(String path)=> _imageUrl + path;

  Future<String> auth(
      {required String username, required String password}) async {
    final token = await _makeToken();
    final validateUser = await _validateUser(
        userName: username, userPassword: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validateUser);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }


  Future<T> _post<T>(String path, Map<String, dynamic> bodyParameters,
      T Function(dynamic json) parser,
      [Map<String, dynamic>? urlparameters]) async {
    try {
      final url = _makeUri(path, urlparameters);

      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      //jdu otvet
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      //result Map
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = _get('/authentication/token/new', parser,
        <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  Future<PopularMovieResponse> popularMovie(int page,String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get('/movie/popular', parser,
        <String, dynamic>{'api_key': _apiKey,'page':page.toString(),'language':locale});
    return result;
  }

  Future<PopularMovieResponse> searchMovie(int page,String locale,String query) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get('/search/movie', parser,
        <String, dynamic>{'api_key': _apiKey,'page':page.toString(),'language':locale,'query': query,'include_adult': true.toString()});
    return result;
  }

  Future<String> _validateUser(
      {required String userName,
      required String userPassword,
      required String requestToken}) async {
    final parameters = <String, dynamic>{
      'username': userName,
      'password': userPassword,
      'request_token': requestToken
    };
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = _post('/authentication/token/validate_with_login',
        parameters, parser, <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  Future<String> _makeSession({required String requestToken}) async {
    final parameters = <String, dynamic>{
      'request_token': requestToken};

    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final result = _post('/authentication/session/new',
        parameters, parser, <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        //decodiruem v json
        .then<dynamic>((v) => json.decode(v));
  }
}
