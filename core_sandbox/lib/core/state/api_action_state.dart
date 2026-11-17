
import 'package:equatable/equatable.dart';
import 'package:win/core/error/app_exception.dart';

enum ApiActionStatus { initial, loading, success, failure }

class ApiActionState extends Equatable {
  final ApiActionStatus status;
  final AppException? exception;

  const ApiActionState({
    this.status = ApiActionStatus.initial,
    this.exception,
  });

  const ApiActionState.initial() : this();

  const ApiActionState.loading()
      : this(status: ApiActionStatus.loading);

  const ApiActionState.success()
      : this(status: ApiActionStatus.success);

  const ApiActionState.failure(AppException exception)
      : this(
    status: ApiActionStatus.failure,
    exception: exception,
  );

  bool get isInitial => status == ApiActionStatus.initial;

  bool get isLoading => status == ApiActionStatus.loading;

  bool get isSuccess => status == ApiActionStatus.success;

  bool get isFailure => status == ApiActionStatus.failure;

  ApiActionState copyWith({
    ApiActionStatus? status,
    AppException? exception,
    bool clearException = false,
  }) {
    return ApiActionState(
      status: status ?? this.status,
      exception: clearException ? null : (exception ?? this.exception),
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
