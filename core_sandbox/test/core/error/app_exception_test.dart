
import 'package:flutter_test/flutter_test.dart';
import 'package:win/core/error/app_exception.dart';

void main() {
  group('AppException subclasses', () {
    final exceptions = <AppException>[
      ApiException(message: 'API error'),
      NetworkException(message: 'Network error'),
      TimeoutException(message: 'Timeout error'),
      CancelledException(message: 'Cancelled error'),
      UnauthorizedException(message: 'Unauthorized error'),
      ForbiddenException(message: 'Forbidden error'),
      NotFoundException(message: 'Not found error'),
      MethodNotAllowedException(message: 'Method not allowed'),
      ValidationException(message: 'Validation error'),
      ServerException(message: 'Server error'),
      ParsingException(message: 'Parsing error'),
      LocalDataException(message: 'Local data error'),
      RedirectException(message: 'Redirect error'),
      UnknownException(message: 'Unknown error'),
    ];

    final expectedTypes = <AppErrorType>[
      AppErrorType.api,
      AppErrorType.network,
      AppErrorType.timeout,
      AppErrorType.cancelled,
      AppErrorType.unauthorized,
      AppErrorType.forbidden,
      AppErrorType.notFound,
      AppErrorType.methodNotAllowed,
      AppErrorType.validation,
      AppErrorType.server,
      AppErrorType.parsing,
      AppErrorType.local,
      AppErrorType.redirect,
      AppErrorType.unknown,
    ];

    final expectedScreenTypes = <ApiErrorScreenType>[
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.screen,
      ApiErrorScreenType.dialog,
      ApiErrorScreenType.none,
      ApiErrorScreenType.screen,
      ApiErrorScreenType.screen,
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.dialog,
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.snackBar,
      ApiErrorScreenType.dialog,
    ];

    test('all subclasses have the correct type', () {
      for (var i = 0; i < exceptions.length; i++) {
        expect(exceptions[i].type, expectedTypes[i]);
      }
    });

    test('all subclasses have the correct default screen type', () {
      for (var i = 0; i < exceptions.length; i++) {
        expect(exceptions[i].screenType, expectedScreenTypes[i]);
      }
    });

    test('all subclasses preserve their message', () {
      for (final exception in exceptions) {
        expect(exception.message, isNotEmpty);
      }
    });
  });

  group('AppException isRetryable', () {
    test('network errors are retryable', () {
      final exception = NetworkException(message: 'Network error');

      expect(exception.isRetryable, isTrue);
    });

    test('timeout errors are retryable', () {
      final exception = TimeoutException(message: 'Timeout error');

      expect(exception.isRetryable, isTrue);
    });

    test('server errors are retryable', () {
      final exception = ServerException(message: 'Server error');

      expect(exception.isRetryable, isTrue);
    });

    test('other errors are not retryable', () {
      final exceptions = <AppException>[
        ApiException(message: 'API error'),
        CancelledException(message: 'Cancelled'),
        UnauthorizedException(message: 'Unauthorized'),
        ForbiddenException(message: 'Forbidden'),
        NotFoundException(message: 'Not found'),
        MethodNotAllowedException(message: 'Method not allowed'),
        ValidationException(message: 'Validation'),
        ParsingException(message: 'Parsing'),
        LocalDataException(message: 'Local data'),
        RedirectException(message: 'Redirect'),
        UnknownException(message: 'Unknown'),
      ];

      for (final exception in exceptions) {
        expect(exception.isRetryable, isFalse);
      }
    });
  });

  group('AppException properties', () {
    test('stores all supplied properties', () {
      final cause = Exception('Original error');
      final trace = StackTrace.current;

      final exception = NetworkException(
        message: 'Network unavailable',
        info: 'Please check your connection',
        statusCode: 503,
        cause: cause,
        trace: trace,
      );

      expect(exception.message, 'Network unavailable');
      expect(exception.info, 'Please check your connection');
      expect(exception.statusCode, 503);
      expect(exception.cause, same(cause));
      expect(exception.trace, same(trace));
    });

    test('optional properties are null by default', () {
      final exception = NetworkException(message: 'Network error');

      expect(exception.info, isNull);
      expect(exception.statusCode, isNull);
      expect(exception.cause, isNull);
      expect(exception.trace, isNull);
    });

    test('allows overriding the default screen type', () {
      final exception = NetworkException(
        message: 'Network error',
        screenType: ApiErrorScreenType.dialog,
      );

      expect(exception.screenType, ApiErrorScreenType.dialog);
    });
  });

  group('AppException toString', () {
    test('does not include status code when it is null', () {
      final exception = NetworkException(message: 'Network error');

      expect(
        exception.toString(),
        'AppException(type: AppErrorType.network, '
            'screenType: ApiErrorScreenType.screen, '
            'message: Network error)',
      );
    });

    test('includes status code when it is provided', () {
      final exception = ServerException(
        message: 'Server error',
        statusCode: 500,
      );

      expect(
        exception.toString(),
        'AppException(type: AppErrorType.server, '
            'statusCode: 500, '
            'screenType: ApiErrorScreenType.dialog, '
            'message: Server error)',
      );
    });
  });

  group('APIErrorCode', () {
    test('contains the correct HTTP status codes', () {
      expect(APIErrorCode.gatewayTimeout.code, 504);
      expect(APIErrorCode.internalServerError.code, 500);
      expect(APIErrorCode.notFound.code, 404);
    });
  });
}
