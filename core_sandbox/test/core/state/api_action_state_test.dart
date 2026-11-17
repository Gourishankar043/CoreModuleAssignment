
import 'package:flutter_test/flutter_test.dart';
import 'package:win/core/error/app_exception.dart';
import 'package:win/core/state/api_action_state.dart';

void main() {
  group('ApiActionState constructors and getters', () {
    test('initial constructor sets initial status', () {
      const state = ApiActionState.initial();

      expect(state.status, ApiActionStatus.initial);
      expect(state.isInitial, true);
      expect(state.isLoading, false);
      expect(state.isSuccess, false);
      expect(state.isFailure, false);
      expect(state.exception, isNull);
    });

    test('loading constructor sets loading status', () {
      const state = ApiActionState.loading();

      expect(state.status, ApiActionStatus.loading);
      expect(state.isLoading, true);
      expect(state.isInitial, false);
      expect(state.isSuccess, false);
      expect(state.isFailure, false);
      expect(state.exception, isNull);
    });

    test('success constructor sets success status', () {
      const state = ApiActionState.success();

      expect(state.status, ApiActionStatus.success);
      expect(state.isSuccess, true);
      expect(state.isInitial, false);
      expect(state.isLoading, false);
      expect(state.isFailure, false);
      expect(state.exception, isNull);
    });

    test('failure constructor sets failure status and exception', () {
      const exception = ApiException(
        message: 'Something went wrong',
      );

      const state = ApiActionState.failure(exception);

      expect(state.status, ApiActionStatus.failure);
      expect(state.isFailure, true);
      expect(state.isInitial, false);
      expect(state.isLoading, false);
      expect(state.isSuccess, false);
      expect(state.exception, exception);
    });

    test('two failures with the same exception are equal', () {
      const exception = ApiException(
        message: 'Something went wrong',
      );

      const first = ApiActionState.failure(exception);
      const second = ApiActionState.failure(exception);

      expect(first, equals(second));
    });
  });

  group('ApiActionState copyWith', () {
    const exception = ApiException(
      message: 'Something went wrong',
    );

    const failedState = ApiActionState.failure(exception);

    test('changing status keeps the old exception', () {
      final result = failedState.copyWith(
        status: ApiActionStatus.success,
      );

      expect(result.status, ApiActionStatus.success);
      expect(result.exception, exception);
    });

    test('passing exception null does not clear old exception', () {
      final result = failedState.copyWith(
        exception: null,
      );

      expect(result.exception, exception);
    });

    test('clearException true removes old exception', () {
      final result = failedState.copyWith(
        clearException: true,
      );

      expect(result.exception, isNull);
      expect(result.status, ApiActionStatus.failure);
    });

    test('clearException true takes priority over new exception', () {
      const newException = ApiException(
        message: 'New error',
      );

      final result = failedState.copyWith(
        exception: newException,
        clearException: true,
      );

      expect(result.exception, isNull);
    });
  });
}
