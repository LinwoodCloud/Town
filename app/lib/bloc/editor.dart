import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

class EditorCubit extends Cubit<SetonixData> {
  final String path;
  final SetonixFileSystem fileSystem;

  EditorCubit(this.path, this.fileSystem, super.initialState);

  void updateMeta(FileMetadata meta) => emit(state.setFileMetadata(meta));

  @override
  void onChange(Change<SetonixData> change) {
    super.onChange(change);

    save();
  }

  Future<void> save() {
    return fileSystem.editorSystem.updateFile(path, state);
  }
}
