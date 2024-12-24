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

  bool _needsSave = false;
  bool _isSaving = false;

  Future<void> save() async {
    _needsSave = true;
    if (_isSaving) {
      return;
    }
    _isSaving = true;
    while (_needsSave) {
      _needsSave = false;
      await fileSystem.editorSystem.updateFile(path, state);
    }
    _isSaving = false;
  }

  void removeFigure(String figure) {
    emit(state.removeFigure(figure));
  }

  void setFigure(String figure, FigureDefinition definition) {
    emit(state.setFigure(figure, definition));
  }
}