import 'package:dart_mappable/dart_mappable.dart';

part 'dialog.mapper.dart';

@MappableClass()
final class GameDialog with GameDialogMappable {
  final String title;
  final String id;
  final List<GameDialogComponent> components;
  final List<GameDialogButton>? actions;
  final String? image;

  GameDialog({
    required this.id,
    required this.title,
    this.image,
    this.components = const [],
    this.actions,
  });

  GameDialog withImage(String image) => copyWith(image: image);

  GameDialog markdown(String content) => copyWith.components.add(
        GameDialogMarkdownComponent(content),
      );

  GameDialog textField(
    String label, {
    String? id,
    String? placeholder,
    bool multiline = false,
    bool password = false,
  }) =>
      copyWith.components.add(
        GameDialogTextFieldComponent(
          label,
          id: id,
          placeholder: placeholder,
          multiline: multiline,
          password: password,
        ),
      );

  GameDialog action(GameDialogButton action) => copyWith(
        actions: [...(actions ?? []), action],
      );

  bool isValid() =>
      (actions?.length ?? 1) <= 10 &&
      components.length <= 20 &&
      components.every((e) {
        switch (e) {
          case GameDialogMarkdownComponent():
            return e.content.length <= 5000;
          case GameDialogTextFieldComponent():
            return e.label.length <= 50 &&
                (e.id?.length ?? 0) <= 100 &&
                (e.placeholder?.length ?? 0) <= 50;
          default:
            return false;
        }
      }) &&
      (actions ?? [])
          .every((e) => e.label.length <= 50 && (e.id?.length ?? 0) <= 100);
}

@MappableClass()
sealed class GameDialogComponent with GameDialogComponentMappable {}

@MappableClass()
final class GameDialogMarkdownComponent extends GameDialogComponent
    with GameDialogMarkdownComponentMappable {
  final String content;

  GameDialogMarkdownComponent(this.content);
}

@MappableClass()
final class GameDialogTextFieldComponent extends GameDialogComponent
    with GameDialogTextFieldComponentMappable {
  final String label;
  final String? id;
  final String? placeholder;
  final bool multiline;
  final bool password;

  GameDialogTextFieldComponent(
    this.label, {
    this.id,
    this.placeholder,
    this.multiline = false,
    this.password = false,
  });

  String get idOrLabel => id ?? label;
}

@MappableClass()
final class GameDialogButton with GameDialogButtonMappable {
  final String label;
  final String? id;

  GameDialogButton(this.label, {this.id});

  String get idOrLabel => id ?? label;
}

@MappableClass()
base class GameDialogValue with GameDialogValueMappable {
  final String buttonPressed;
  final Map<String, GameDialogComponentValue> values;

  GameDialogValue([
    this.values = const {},
    this.buttonPressed = '',
  ]);

  bool hasValue(String key) => values.containsKey(key);
  GameDialogComponentValue getValue(String key) =>
      values[key] ??
      GameDialogComponentValue(
        component: -1,
      );
}

@MappableClass()
base class GameDialogComponentValue with GameDialogComponentValueMappable {
  final int component;

  GameDialogComponentValue({required this.component});
  String getAsString() => '';
  bool getAsBool() => false;
  int getAsInt() => 0;
}

@MappableClass()
final class GameDialogTextFieldValue extends GameDialogComponentValue
    with GameDialogTextFieldValueMappable {
  final String value;

  GameDialogTextFieldValue({
    required this.value,
    required super.component,
  });

  @override
  String getAsString() => value;
  @override
  bool getAsBool() => value.isNotEmpty;
  @override
  int getAsInt() => int.tryParse(value) ?? 0;
}
