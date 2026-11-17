
import 'package:flutter_test/flutter_test.dart';
import 'package:win/core/error/app_exception.dart';
import 'package:win/core/error/exception_handler.dart';

void main() {
  group('ExceptionHandler.toAppException', () {
    test('returns the same object when error is already AppException', () {
      final error = NetworkException(message: 'Network error');

      final result = ExceptionHandler.toAppException(
        error,
        stackTrace: StackTrace.current,
        message: 'Something went wrong',
      );

      expect(result, same(error));
    });

    test('converts ordinary error into UnknownException', () {
      final error = FormatException('Invalid JSON');

      final result = ExceptionHandler.toAppException(
        error,
        stackTrace: StackTrace.current,
        message: 'Unable to process data',
      );

      expect(result, isA<UnknownException>());
      expect(result.type, AppErrorType.unknown);
      expect(result.screenType, ApiErrorScreenType.dialog);
    });

    test('uses supplied message when appendCauseToMessage is false', () {
      final error = Exception('Original error');

      final result = ExceptionHandler.toAppException(
        error,
        stackTrace: StackTrace.current,
        message: 'Something went wrong',
      );

      expect(result.message, 'Something went wrong');
    });

    test('appends original error when appendCauseToMessage is true', () {
      final error = Exception('Original error');

      final result = ExceptionHandler.toAppException(
        error,
        stackTrace: StackTrace.current,
        message: 'Something went wrong',
        appendCauseToMessage: true,
      );

      expect(
        result.message,
        'Something went wrong: $error',
      );
    });

    test('preserves original error in cause', () {
      final error = FormatException('Invalid JSON');

      final result = ExceptionHandler.toAppException(
        error,
        stackTrace: StackTrace.current,
        message: 'Unable to process data',
      );

      expect(result.cause, same(error));
    });

    test('preserves supplied stack trace', () {
      final error = Exception('Original error');
      final stackTrace = StackTrace.current;

      final result = ExceptionHandler.toAppException(
        error,
        stackTrace: stackTrace,
        message: 'Something went wrong',
      );

      expect(result.trace, same(stackTrace));
    });
  });
}
