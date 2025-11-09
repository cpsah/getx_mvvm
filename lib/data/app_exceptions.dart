class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix: $_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String message = 'No Internet connection'])
      : super(message, 'No internet Exception');
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String message = 'Request timed out'])
      : super(message, 'Request Timeout Exception');
}

class ServerException extends AppExceptions {
  ServerException([String message = 'Internal server error'])
      : super(message, 'Server Exception');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String message = 'Unauthorized access'])
      : super(message, 'Unauthorized Exception');
}