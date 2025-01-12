import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix_api/setonix_api.dart';

class EditorCubit extends Cubit<SetonixData> {
  final String path;
  final SetonixFileSystem fileSystem;

  EditorCubit(this.path, this.fileSystem, super.initialState);

  void updateMeta(FileMetadata meta) => emit(state.setMetadata(meta));

  @override
  void onChange(Change<SetonixData> change) {
    super.onChange(change);

    _save(change.nextState);
  }

  bool _needsSave = false;
  bool _isSaving = false;

  Future<void> _save(SetonixData data) async {
    _needsSave = true;
    if (_isSaving) {
      return;
    }
    _isSaving = true;
    while (_needsSave) {
      _needsSave = false;
      await fileSystem.editorSystem.updateFile(path, data);
    }
    _isSaving = false;
  }

  void removeFigure(String figure) => emit(state.removeFigure(figure));

  void setFigure(String figure, FigureDefinition definition) =>
      emit(state.setFigure(figure, definition));

  void removeDeck(String deck) => emit(state.removeDeck(deck));

  void setDeck(String deck, DeckDefinition definition) =>
      emit(state.setDeck(deck, definition));

  void removeBackground(String background) =>
      emit(state.removeBackground(background));

  void setBackground(String background, BackgroundDefinition definition) =>
      emit(state.setBackground(background, definition));

  void setTranslation(PackTranslation translation,
          [String locale = kFallbackLocale]) =>
      emit(state.setTranslation(translation, locale));

  void removeTexture(String texture) => emit(state.removeTexture(texture));

  void setTexture(String name, Uint8List bytes) =>
      emit(state.setTexture(name, bytes));

  void removeBoard(String id) => emit(state.removeBoard(id));

  void setBoard(String id, BoardDefinition definition) =>
      emit(state.setBoard(id, definition));
}
