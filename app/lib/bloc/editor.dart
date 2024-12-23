import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix_api/setonix_api.dart';

class EditorCubit extends Cubit<SetonixData> {
  final String path;

  EditorCubit(this.path, super.initialState);

  void updateMeta(FileMetadata meta) => emit(state.setFileMetadata(meta));
}
