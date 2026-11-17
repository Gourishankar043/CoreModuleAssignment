
enum AppErrorType {
  network,
  timeout,
  cancelled,
  unauthorized,
  forbidden,
  notFound,
  methodNotAllowed,
  validation,
  server,
  api,
  parsing,
  local,
  redirect,
  unknown,
}

enum ApiErrorScreenType {
  snackBar,
  dialog,
  screen,
  none,
}

enum APIErrorCode {
  gatewayTimeout(504),
  internalServerError(500),
  notFound(404);

  final int code;

  const APIErrorCode(this.code);
}

class AppException implements Exception {
  final String message;
  final String? info;
  final AppErrorType type;
  final ApiErrorScreenType screenType;
  final int? statusCode;
  final Object? cause;
  final StackTrace? trace;

  const AppException({
    required this.message,
    this.info,
    required this.type,
    required this.screenType,
    this.statusCode,
    this.cause,
    this.trace,
  });

  bool get isRetryable =>
      type == AppErrorType.network ||
          type == AppErrorType.timeout ||
          type == AppErrorType.server;

  @override
  String toString() {
    final codePart =
    statusCode == null ? '' : ', statusCode: $statusCode';

    return 'AppException(type: $type$codePart, '
        'screenType: $screenType, message: $message)';
  }
}

class ApiException extends AppException {
  const ApiException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.api);
}

class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.screen,
  }) : super(type: AppErrorType.network);
}

class TimeoutException extends AppException {
  const TimeoutException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.dialog,
  }) : super(type: AppErrorType.timeout);
}

class CancelledException extends AppException {
  const CancelledException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.none,
  }) : super(type: AppErrorType.cancelled);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.screen,
  }) : super(type: AppErrorType.unauthorized);
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.screen,
  }) : super(type: AppErrorType.forbidden);
}

class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.notFound);
}

class MethodNotAllowedException extends AppException {
  const MethodNotAllowedException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.methodNotAllowed);
}

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.validation);
}

class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.dialog,
  }) : super(type: AppErrorType.server);
}

class ParsingException extends AppException {
  const ParsingException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.parsing);
}

class LocalDataException extends AppException {
  const LocalDataException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.local);
}

class RedirectException extends AppException {
  const RedirectException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.snackBar,
  }) : super(type: AppErrorType.redirect);
}

class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.info,
    super.statusCode,
    super.cause,
    super.trace,
    super.screenType = ApiErrorScreenType.dialog,
  }) : super(type: AppErrorType.unknown);
}
