part of 'sync_data_bloc.dart';

@freezed
class SyncDataState with _$SyncDataState {
  const factory SyncDataState.initial() = _Initial;
  const factory SyncDataState.loading() = _Loading;
  const factory SyncDataState.success({required String message}) = _Success;
  const factory SyncDataState.failed({required String message}) = _Failed;
}
