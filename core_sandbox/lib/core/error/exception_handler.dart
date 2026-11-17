
import 'package:win/core/error/app_exception.dart';

class ExceptionHandler {
  const ExceptionHandler._();

  static AppException toAppException(
      Object error, {
        required StackTrace stackTrace,
        required String message,
        bool appendCauseToMessage = false,
      }) {
    // If already an AppException, return the same object.
    if (error is AppException) {
      return error;
    }

    // Prepare the error message.
    final resolvedMessage =
    appendCauseToMessage ? '$message: $error' : message;

    // Convert ordinary errors into UnknownException.
    return UnknownException(
      message: resolvedMessage,
      cause: error,
      trace: stackTrace,
    );
  }
}
