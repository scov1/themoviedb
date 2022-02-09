import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier{ 

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get canAuthProgress => _isAuthProgress;
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<void> auth(BuildContext context)async{
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if(login.isEmpty || password.isEmpty){
      _errorMessage = 'Error with login or password!';
      notifyListeners();
      return;
    }
    _errorMessage =null;
    _isAuthProgress = true;
    //obnovlyayu model
    notifyListeners();
    String? sessionId;
    try{
      sessionId = await _apiClient.auth(username: login,password: password);
    }on ApiClientException catch(e){
      switch(e.type){
        case ApiClientExceptionType.Network:
        _errorMessage = 'Internet not available.Check your connection!';
        break;
        case ApiClientExceptionType.Auth:
        _errorMessage = 'Not validate login or password';
        break;
        case ApiClientExceptionType.Other:
        _errorMessage = 'Server disconnected,Please try later';
        break;
      }
    }
    
    _isAuthProgress = false;
  
    if(_errorMessage != null){
      notifyListeners();
      return;
    }
    if(sessionId == null){
      _errorMessage = 'Unkown error,please try again!';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen));

    notifyListeners();
  }
}

