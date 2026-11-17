
import 'package:win/core/app_export.dart';

class SampleEntity extends Equatable {
  const SampleEntity();

  @override
  List<Object?> get props => [];
}

class SampleCubit extends Cubit<int> {
  SampleCubit() : super(0);
}
