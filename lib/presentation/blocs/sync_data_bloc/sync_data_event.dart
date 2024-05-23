part of 'sync_data_bloc.dart';

@freezed
class SyncDataEvent with _$SyncDataEvent {
  const factory SyncDataEvent.doSync() = _DoSync;
}
