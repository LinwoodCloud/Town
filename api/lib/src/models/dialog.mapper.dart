// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dialog.dart';

class GameDialogMapper extends ClassMapperBase<GameDialog> {
  GameDialogMapper._();

  static GameDialogMapper? _instance;
  static GameDialogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogMapper._());
      GameDialogComponentMapper.ensureInitialized();
      GameDialogButtonMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialog';

  static String _$id(GameDialog v) => v.id;
  static const Field<GameDialog, String> _f$id = Field('id', _$id);
  static String _$title(GameDialog v) => v.title;
  static const Field<GameDialog, String> _f$title = Field('title', _$title);
  static String? _$image(GameDialog v) => v.image;
  static const Field<GameDialog, String> _f$image =
      Field('image', _$image, opt: true);
  static List<GameDialogComponent> _$components(GameDialog v) => v.components;
  static const Field<GameDialog, List<GameDialogComponent>> _f$components =
      Field('components', _$components, opt: true, def: const []);
  static List<GameDialogButton>? _$actions(GameDialog v) => v.actions;
  static const Field<GameDialog, List<GameDialogButton>> _f$actions =
      Field('actions', _$actions, opt: true);

  @override
  final MappableFields<GameDialog> fields = const {
    #id: _f$id,
    #title: _f$title,
    #image: _f$image,
    #components: _f$components,
    #actions: _f$actions,
  };

  static GameDialog _instantiate(DecodingData data) {
    return GameDialog(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        image: data.dec(_f$image),
        components: data.dec(_f$components),
        actions: data.dec(_f$actions));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialog>(map);
  }

  static GameDialog fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialog>(json);
  }
}

mixin GameDialogMappable {
  String toJson() {
    return GameDialogMapper.ensureInitialized()
        .encodeJson<GameDialog>(this as GameDialog);
  }

  Map<String, dynamic> toMap() {
    return GameDialogMapper.ensureInitialized()
        .encodeMap<GameDialog>(this as GameDialog);
  }

  GameDialogCopyWith<GameDialog, GameDialog, GameDialog> get copyWith =>
      _GameDialogCopyWithImpl(this as GameDialog, $identity, $identity);
  @override
  String toString() {
    return GameDialogMapper.ensureInitialized()
        .stringifyValue(this as GameDialog);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogMapper.ensureInitialized()
        .equalsValue(this as GameDialog, other);
  }

  @override
  int get hashCode {
    return GameDialogMapper.ensureInitialized().hashValue(this as GameDialog);
  }
}

extension GameDialogValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialog, $Out> {
  GameDialogCopyWith<$R, GameDialog, $Out> get $asGameDialog =>
      $base.as((v, t, t2) => _GameDialogCopyWithImpl(v, t, t2));
}

abstract class GameDialogCopyWith<$R, $In extends GameDialog, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      GameDialogComponent,
      GameDialogComponentCopyWith<$R, GameDialogComponent,
          GameDialogComponent>> get components;
  ListCopyWith<$R, GameDialogButton,
          GameDialogButtonCopyWith<$R, GameDialogButton, GameDialogButton>>?
      get actions;
  $R call(
      {String? id,
      String? title,
      String? image,
      List<GameDialogComponent>? components,
      List<GameDialogButton>? actions});
  GameDialogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameDialogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialog, $Out>
    implements GameDialogCopyWith<$R, GameDialog, $Out> {
  _GameDialogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialog> $mapper =
      GameDialogMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      GameDialogComponent,
      GameDialogComponentCopyWith<$R, GameDialogComponent,
          GameDialogComponent>> get components => ListCopyWith(
      $value.components,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(components: v));
  @override
  ListCopyWith<$R, GameDialogButton,
          GameDialogButtonCopyWith<$R, GameDialogButton, GameDialogButton>>?
      get actions => $value.actions != null
          ? ListCopyWith($value.actions!, (v, t) => v.copyWith.$chain(t),
              (v) => call(actions: v))
          : null;
  @override
  $R call(
          {String? id,
          String? title,
          Object? image = $none,
          List<GameDialogComponent>? components,
          Object? actions = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (image != $none) #image: image,
        if (components != null) #components: components,
        if (actions != $none) #actions: actions
      }));
  @override
  GameDialog $make(CopyWithData data) => GameDialog(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      image: data.get(#image, or: $value.image),
      components: data.get(#components, or: $value.components),
      actions: data.get(#actions, or: $value.actions));

  @override
  GameDialogCopyWith<$R2, GameDialog, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameDialogCopyWithImpl($value, $cast, t);
}

class GameDialogComponentMapper extends ClassMapperBase<GameDialogComponent> {
  GameDialogComponentMapper._();

  static GameDialogComponentMapper? _instance;
  static GameDialogComponentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogComponentMapper._());
      GameDialogMarkdownComponentMapper.ensureInitialized();
      GameDialogTextFieldComponentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogComponent';

  @override
  final MappableFields<GameDialogComponent> fields = const {};

  static GameDialogComponent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GameDialogComponent');
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogComponent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogComponent>(map);
  }

  static GameDialogComponent fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogComponent>(json);
  }
}

mixin GameDialogComponentMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GameDialogComponentCopyWith<GameDialogComponent, GameDialogComponent,
      GameDialogComponent> get copyWith;
}

abstract class GameDialogComponentCopyWith<$R, $In extends GameDialogComponent,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GameDialogComponentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class GameDialogButtonMapper extends ClassMapperBase<GameDialogButton> {
  GameDialogButtonMapper._();

  static GameDialogButtonMapper? _instance;
  static GameDialogButtonMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogButtonMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogButton';

  static String _$label(GameDialogButton v) => v.label;
  static const Field<GameDialogButton, String> _f$label =
      Field('label', _$label);
  static String? _$id(GameDialogButton v) => v.id;
  static const Field<GameDialogButton, String> _f$id =
      Field('id', _$id, opt: true);

  @override
  final MappableFields<GameDialogButton> fields = const {
    #label: _f$label,
    #id: _f$id,
  };

  static GameDialogButton _instantiate(DecodingData data) {
    return GameDialogButton(data.dec(_f$label), id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogButton fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogButton>(map);
  }

  static GameDialogButton fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogButton>(json);
  }
}

mixin GameDialogButtonMappable {
  String toJson() {
    return GameDialogButtonMapper.ensureInitialized()
        .encodeJson<GameDialogButton>(this as GameDialogButton);
  }

  Map<String, dynamic> toMap() {
    return GameDialogButtonMapper.ensureInitialized()
        .encodeMap<GameDialogButton>(this as GameDialogButton);
  }

  GameDialogButtonCopyWith<GameDialogButton, GameDialogButton, GameDialogButton>
      get copyWith => _GameDialogButtonCopyWithImpl(
          this as GameDialogButton, $identity, $identity);
  @override
  String toString() {
    return GameDialogButtonMapper.ensureInitialized()
        .stringifyValue(this as GameDialogButton);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogButtonMapper.ensureInitialized()
        .equalsValue(this as GameDialogButton, other);
  }

  @override
  int get hashCode {
    return GameDialogButtonMapper.ensureInitialized()
        .hashValue(this as GameDialogButton);
  }
}

extension GameDialogButtonValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogButton, $Out> {
  GameDialogButtonCopyWith<$R, GameDialogButton, $Out>
      get $asGameDialogButton =>
          $base.as((v, t, t2) => _GameDialogButtonCopyWithImpl(v, t, t2));
}

abstract class GameDialogButtonCopyWith<$R, $In extends GameDialogButton, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? label, String? id});
  GameDialogButtonCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogButtonCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogButton, $Out>
    implements GameDialogButtonCopyWith<$R, GameDialogButton, $Out> {
  _GameDialogButtonCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogButton> $mapper =
      GameDialogButtonMapper.ensureInitialized();
  @override
  $R call({String? label, Object? id = $none}) => $apply(FieldCopyWithData(
      {if (label != null) #label: label, if (id != $none) #id: id}));
  @override
  GameDialogButton $make(CopyWithData data) =>
      GameDialogButton(data.get(#label, or: $value.label),
          id: data.get(#id, or: $value.id));

  @override
  GameDialogButtonCopyWith<$R2, GameDialogButton, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameDialogButtonCopyWithImpl($value, $cast, t);
}

class GameDialogMarkdownComponentMapper
    extends ClassMapperBase<GameDialogMarkdownComponent> {
  GameDialogMarkdownComponentMapper._();

  static GameDialogMarkdownComponentMapper? _instance;
  static GameDialogMarkdownComponentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = GameDialogMarkdownComponentMapper._());
      GameDialogComponentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogMarkdownComponent';

  static String _$content(GameDialogMarkdownComponent v) => v.content;
  static const Field<GameDialogMarkdownComponent, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<GameDialogMarkdownComponent> fields = const {
    #content: _f$content,
  };

  static GameDialogMarkdownComponent _instantiate(DecodingData data) {
    return GameDialogMarkdownComponent(data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogMarkdownComponent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogMarkdownComponent>(map);
  }

  static GameDialogMarkdownComponent fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogMarkdownComponent>(json);
  }
}

mixin GameDialogMarkdownComponentMappable {
  String toJson() {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .encodeJson<GameDialogMarkdownComponent>(
            this as GameDialogMarkdownComponent);
  }

  Map<String, dynamic> toMap() {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .encodeMap<GameDialogMarkdownComponent>(
            this as GameDialogMarkdownComponent);
  }

  GameDialogMarkdownComponentCopyWith<GameDialogMarkdownComponent,
          GameDialogMarkdownComponent, GameDialogMarkdownComponent>
      get copyWith => _GameDialogMarkdownComponentCopyWithImpl(
          this as GameDialogMarkdownComponent, $identity, $identity);
  @override
  String toString() {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .stringifyValue(this as GameDialogMarkdownComponent);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .equalsValue(this as GameDialogMarkdownComponent, other);
  }

  @override
  int get hashCode {
    return GameDialogMarkdownComponentMapper.ensureInitialized()
        .hashValue(this as GameDialogMarkdownComponent);
  }
}

extension GameDialogMarkdownComponentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogMarkdownComponent, $Out> {
  GameDialogMarkdownComponentCopyWith<$R, GameDialogMarkdownComponent, $Out>
      get $asGameDialogMarkdownComponent => $base
          .as((v, t, t2) => _GameDialogMarkdownComponentCopyWithImpl(v, t, t2));
}

abstract class GameDialogMarkdownComponentCopyWith<
    $R,
    $In extends GameDialogMarkdownComponent,
    $Out> implements GameDialogComponentCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content});
  GameDialogMarkdownComponentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogMarkdownComponentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogMarkdownComponent, $Out>
    implements
        GameDialogMarkdownComponentCopyWith<$R, GameDialogMarkdownComponent,
            $Out> {
  _GameDialogMarkdownComponentCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogMarkdownComponent> $mapper =
      GameDialogMarkdownComponentMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  GameDialogMarkdownComponent $make(CopyWithData data) =>
      GameDialogMarkdownComponent(data.get(#content, or: $value.content));

  @override
  GameDialogMarkdownComponentCopyWith<$R2, GameDialogMarkdownComponent, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GameDialogMarkdownComponentCopyWithImpl($value, $cast, t);
}

class GameDialogTextFieldComponentMapper
    extends ClassMapperBase<GameDialogTextFieldComponent> {
  GameDialogTextFieldComponentMapper._();

  static GameDialogTextFieldComponentMapper? _instance;
  static GameDialogTextFieldComponentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = GameDialogTextFieldComponentMapper._());
      GameDialogComponentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogTextFieldComponent';

  static String _$label(GameDialogTextFieldComponent v) => v.label;
  static const Field<GameDialogTextFieldComponent, String> _f$label =
      Field('label', _$label);
  static String? _$id(GameDialogTextFieldComponent v) => v.id;
  static const Field<GameDialogTextFieldComponent, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$placeholder(GameDialogTextFieldComponent v) => v.placeholder;
  static const Field<GameDialogTextFieldComponent, String> _f$placeholder =
      Field('placeholder', _$placeholder, opt: true);
  static bool _$multiline(GameDialogTextFieldComponent v) => v.multiline;
  static const Field<GameDialogTextFieldComponent, bool> _f$multiline =
      Field('multiline', _$multiline, opt: true, def: false);
  static bool _$password(GameDialogTextFieldComponent v) => v.password;
  static const Field<GameDialogTextFieldComponent, bool> _f$password =
      Field('password', _$password, opt: true, def: false);

  @override
  final MappableFields<GameDialogTextFieldComponent> fields = const {
    #label: _f$label,
    #id: _f$id,
    #placeholder: _f$placeholder,
    #multiline: _f$multiline,
    #password: _f$password,
  };

  static GameDialogTextFieldComponent _instantiate(DecodingData data) {
    return GameDialogTextFieldComponent(data.dec(_f$label),
        id: data.dec(_f$id),
        placeholder: data.dec(_f$placeholder),
        multiline: data.dec(_f$multiline),
        password: data.dec(_f$password));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogTextFieldComponent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogTextFieldComponent>(map);
  }

  static GameDialogTextFieldComponent fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogTextFieldComponent>(json);
  }
}

mixin GameDialogTextFieldComponentMappable {
  String toJson() {
    return GameDialogTextFieldComponentMapper.ensureInitialized()
        .encodeJson<GameDialogTextFieldComponent>(
            this as GameDialogTextFieldComponent);
  }

  Map<String, dynamic> toMap() {
    return GameDialogTextFieldComponentMapper.ensureInitialized()
        .encodeMap<GameDialogTextFieldComponent>(
            this as GameDialogTextFieldComponent);
  }

  GameDialogTextFieldComponentCopyWith<GameDialogTextFieldComponent,
          GameDialogTextFieldComponent, GameDialogTextFieldComponent>
      get copyWith => _GameDialogTextFieldComponentCopyWithImpl(
          this as GameDialogTextFieldComponent, $identity, $identity);
  @override
  String toString() {
    return GameDialogTextFieldComponentMapper.ensureInitialized()
        .stringifyValue(this as GameDialogTextFieldComponent);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogTextFieldComponentMapper.ensureInitialized()
        .equalsValue(this as GameDialogTextFieldComponent, other);
  }

  @override
  int get hashCode {
    return GameDialogTextFieldComponentMapper.ensureInitialized()
        .hashValue(this as GameDialogTextFieldComponent);
  }
}

extension GameDialogTextFieldComponentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogTextFieldComponent, $Out> {
  GameDialogTextFieldComponentCopyWith<$R, GameDialogTextFieldComponent, $Out>
      get $asGameDialogTextFieldComponent => $base.as(
          (v, t, t2) => _GameDialogTextFieldComponentCopyWithImpl(v, t, t2));
}

abstract class GameDialogTextFieldComponentCopyWith<
    $R,
    $In extends GameDialogTextFieldComponent,
    $Out> implements GameDialogComponentCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? label,
      String? id,
      String? placeholder,
      bool? multiline,
      bool? password});
  GameDialogTextFieldComponentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogTextFieldComponentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogTextFieldComponent, $Out>
    implements
        GameDialogTextFieldComponentCopyWith<$R, GameDialogTextFieldComponent,
            $Out> {
  _GameDialogTextFieldComponentCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogTextFieldComponent> $mapper =
      GameDialogTextFieldComponentMapper.ensureInitialized();
  @override
  $R call(
          {String? label,
          Object? id = $none,
          Object? placeholder = $none,
          bool? multiline,
          bool? password}) =>
      $apply(FieldCopyWithData({
        if (label != null) #label: label,
        if (id != $none) #id: id,
        if (placeholder != $none) #placeholder: placeholder,
        if (multiline != null) #multiline: multiline,
        if (password != null) #password: password
      }));
  @override
  GameDialogTextFieldComponent $make(CopyWithData data) =>
      GameDialogTextFieldComponent(data.get(#label, or: $value.label),
          id: data.get(#id, or: $value.id),
          placeholder: data.get(#placeholder, or: $value.placeholder),
          multiline: data.get(#multiline, or: $value.multiline),
          password: data.get(#password, or: $value.password));

  @override
  GameDialogTextFieldComponentCopyWith<$R2, GameDialogTextFieldComponent, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GameDialogTextFieldComponentCopyWithImpl($value, $cast, t);
}

class GameDialogValueMapper extends ClassMapperBase<GameDialogValue> {
  GameDialogValueMapper._();

  static GameDialogValueMapper? _instance;
  static GameDialogValueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameDialogValueMapper._());
      GameDialogComponentValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogValue';

  static Map<String, GameDialogComponentValue> _$values(GameDialogValue v) =>
      v.values;
  static const Field<GameDialogValue, Map<String, GameDialogComponentValue>>
      _f$values = Field('values', _$values, opt: true, def: const {});
  static String _$buttonPressed(GameDialogValue v) => v.buttonPressed;
  static const Field<GameDialogValue, String> _f$buttonPressed =
      Field('buttonPressed', _$buttonPressed, opt: true, def: '');

  @override
  final MappableFields<GameDialogValue> fields = const {
    #values: _f$values,
    #buttonPressed: _f$buttonPressed,
  };

  static GameDialogValue _instantiate(DecodingData data) {
    return GameDialogValue(data.dec(_f$values), data.dec(_f$buttonPressed));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogValue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogValue>(map);
  }

  static GameDialogValue fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogValue>(json);
  }
}

mixin GameDialogValueMappable {
  String toJson() {
    return GameDialogValueMapper.ensureInitialized()
        .encodeJson<GameDialogValue>(this as GameDialogValue);
  }

  Map<String, dynamic> toMap() {
    return GameDialogValueMapper.ensureInitialized()
        .encodeMap<GameDialogValue>(this as GameDialogValue);
  }

  GameDialogValueCopyWith<GameDialogValue, GameDialogValue, GameDialogValue>
      get copyWith => _GameDialogValueCopyWithImpl(
          this as GameDialogValue, $identity, $identity);
  @override
  String toString() {
    return GameDialogValueMapper.ensureInitialized()
        .stringifyValue(this as GameDialogValue);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogValueMapper.ensureInitialized()
        .equalsValue(this as GameDialogValue, other);
  }

  @override
  int get hashCode {
    return GameDialogValueMapper.ensureInitialized()
        .hashValue(this as GameDialogValue);
  }
}

extension GameDialogValueValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogValue, $Out> {
  GameDialogValueCopyWith<$R, GameDialogValue, $Out> get $asGameDialogValue =>
      $base.as((v, t, t2) => _GameDialogValueCopyWithImpl(v, t, t2));
}

abstract class GameDialogValueCopyWith<$R, $In extends GameDialogValue, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
      $R,
      String,
      GameDialogComponentValue,
      GameDialogComponentValueCopyWith<$R, GameDialogComponentValue,
          GameDialogComponentValue>> get values;
  $R call(
      {Map<String, GameDialogComponentValue>? values, String? buttonPressed});
  GameDialogValueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogValueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogValue, $Out>
    implements GameDialogValueCopyWith<$R, GameDialogValue, $Out> {
  _GameDialogValueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogValue> $mapper =
      GameDialogValueMapper.ensureInitialized();
  @override
  MapCopyWith<
      $R,
      String,
      GameDialogComponentValue,
      GameDialogComponentValueCopyWith<$R, GameDialogComponentValue,
          GameDialogComponentValue>> get values => MapCopyWith(
      $value.values, (v, t) => v.copyWith.$chain(t), (v) => call(values: v));
  @override
  $R call(
          {Map<String, GameDialogComponentValue>? values,
          String? buttonPressed}) =>
      $apply(FieldCopyWithData({
        if (values != null) #values: values,
        if (buttonPressed != null) #buttonPressed: buttonPressed
      }));
  @override
  GameDialogValue $make(CopyWithData data) => GameDialogValue(
      data.get(#values, or: $value.values),
      data.get(#buttonPressed, or: $value.buttonPressed));

  @override
  GameDialogValueCopyWith<$R2, GameDialogValue, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameDialogValueCopyWithImpl($value, $cast, t);
}

class GameDialogComponentValueMapper
    extends ClassMapperBase<GameDialogComponentValue> {
  GameDialogComponentValueMapper._();

  static GameDialogComponentValueMapper? _instance;
  static GameDialogComponentValueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = GameDialogComponentValueMapper._());
      GameDialogTextFieldValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogComponentValue';

  static int _$component(GameDialogComponentValue v) => v.component;
  static const Field<GameDialogComponentValue, int> _f$component =
      Field('component', _$component);

  @override
  final MappableFields<GameDialogComponentValue> fields = const {
    #component: _f$component,
  };

  static GameDialogComponentValue _instantiate(DecodingData data) {
    return GameDialogComponentValue(component: data.dec(_f$component));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogComponentValue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogComponentValue>(map);
  }

  static GameDialogComponentValue fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogComponentValue>(json);
  }
}

mixin GameDialogComponentValueMappable {
  String toJson() {
    return GameDialogComponentValueMapper.ensureInitialized()
        .encodeJson<GameDialogComponentValue>(this as GameDialogComponentValue);
  }

  Map<String, dynamic> toMap() {
    return GameDialogComponentValueMapper.ensureInitialized()
        .encodeMap<GameDialogComponentValue>(this as GameDialogComponentValue);
  }

  GameDialogComponentValueCopyWith<GameDialogComponentValue,
          GameDialogComponentValue, GameDialogComponentValue>
      get copyWith => _GameDialogComponentValueCopyWithImpl(
          this as GameDialogComponentValue, $identity, $identity);
  @override
  String toString() {
    return GameDialogComponentValueMapper.ensureInitialized()
        .stringifyValue(this as GameDialogComponentValue);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogComponentValueMapper.ensureInitialized()
        .equalsValue(this as GameDialogComponentValue, other);
  }

  @override
  int get hashCode {
    return GameDialogComponentValueMapper.ensureInitialized()
        .hashValue(this as GameDialogComponentValue);
  }
}

extension GameDialogComponentValueValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogComponentValue, $Out> {
  GameDialogComponentValueCopyWith<$R, GameDialogComponentValue, $Out>
      get $asGameDialogComponentValue => $base
          .as((v, t, t2) => _GameDialogComponentValueCopyWithImpl(v, t, t2));
}

abstract class GameDialogComponentValueCopyWith<
    $R,
    $In extends GameDialogComponentValue,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? component});
  GameDialogComponentValueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogComponentValueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogComponentValue, $Out>
    implements
        GameDialogComponentValueCopyWith<$R, GameDialogComponentValue, $Out> {
  _GameDialogComponentValueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogComponentValue> $mapper =
      GameDialogComponentValueMapper.ensureInitialized();
  @override
  $R call({int? component}) =>
      $apply(FieldCopyWithData({if (component != null) #component: component}));
  @override
  GameDialogComponentValue $make(CopyWithData data) => GameDialogComponentValue(
      component: data.get(#component, or: $value.component));

  @override
  GameDialogComponentValueCopyWith<$R2, GameDialogComponentValue, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GameDialogComponentValueCopyWithImpl($value, $cast, t);
}

class GameDialogTextFieldValueMapper
    extends ClassMapperBase<GameDialogTextFieldValue> {
  GameDialogTextFieldValueMapper._();

  static GameDialogTextFieldValueMapper? _instance;
  static GameDialogTextFieldValueMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = GameDialogTextFieldValueMapper._());
      GameDialogComponentValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameDialogTextFieldValue';

  static String _$value(GameDialogTextFieldValue v) => v.value;
  static const Field<GameDialogTextFieldValue, String> _f$value =
      Field('value', _$value);
  static int _$component(GameDialogTextFieldValue v) => v.component;
  static const Field<GameDialogTextFieldValue, int> _f$component =
      Field('component', _$component);

  @override
  final MappableFields<GameDialogTextFieldValue> fields = const {
    #value: _f$value,
    #component: _f$component,
  };

  static GameDialogTextFieldValue _instantiate(DecodingData data) {
    return GameDialogTextFieldValue(
        value: data.dec(_f$value), component: data.dec(_f$component));
  }

  @override
  final Function instantiate = _instantiate;

  static GameDialogTextFieldValue fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameDialogTextFieldValue>(map);
  }

  static GameDialogTextFieldValue fromJson(String json) {
    return ensureInitialized().decodeJson<GameDialogTextFieldValue>(json);
  }
}

mixin GameDialogTextFieldValueMappable {
  String toJson() {
    return GameDialogTextFieldValueMapper.ensureInitialized()
        .encodeJson<GameDialogTextFieldValue>(this as GameDialogTextFieldValue);
  }

  Map<String, dynamic> toMap() {
    return GameDialogTextFieldValueMapper.ensureInitialized()
        .encodeMap<GameDialogTextFieldValue>(this as GameDialogTextFieldValue);
  }

  GameDialogTextFieldValueCopyWith<GameDialogTextFieldValue,
          GameDialogTextFieldValue, GameDialogTextFieldValue>
      get copyWith => _GameDialogTextFieldValueCopyWithImpl(
          this as GameDialogTextFieldValue, $identity, $identity);
  @override
  String toString() {
    return GameDialogTextFieldValueMapper.ensureInitialized()
        .stringifyValue(this as GameDialogTextFieldValue);
  }

  @override
  bool operator ==(Object other) {
    return GameDialogTextFieldValueMapper.ensureInitialized()
        .equalsValue(this as GameDialogTextFieldValue, other);
  }

  @override
  int get hashCode {
    return GameDialogTextFieldValueMapper.ensureInitialized()
        .hashValue(this as GameDialogTextFieldValue);
  }
}

extension GameDialogTextFieldValueValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameDialogTextFieldValue, $Out> {
  GameDialogTextFieldValueCopyWith<$R, GameDialogTextFieldValue, $Out>
      get $asGameDialogTextFieldValue => $base
          .as((v, t, t2) => _GameDialogTextFieldValueCopyWithImpl(v, t, t2));
}

abstract class GameDialogTextFieldValueCopyWith<
    $R,
    $In extends GameDialogTextFieldValue,
    $Out> implements GameDialogComponentValueCopyWith<$R, $In, $Out> {
  @override
  $R call({String? value, int? component});
  GameDialogTextFieldValueCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GameDialogTextFieldValueCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameDialogTextFieldValue, $Out>
    implements
        GameDialogTextFieldValueCopyWith<$R, GameDialogTextFieldValue, $Out> {
  _GameDialogTextFieldValueCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameDialogTextFieldValue> $mapper =
      GameDialogTextFieldValueMapper.ensureInitialized();
  @override
  $R call({String? value, int? component}) => $apply(FieldCopyWithData({
        if (value != null) #value: value,
        if (component != null) #component: component
      }));
  @override
  GameDialogTextFieldValue $make(CopyWithData data) => GameDialogTextFieldValue(
      value: data.get(#value, or: $value.value),
      component: data.get(#component, or: $value.component));

  @override
  GameDialogTextFieldValueCopyWith<$R2, GameDialogTextFieldValue, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GameDialogTextFieldValueCopyWithImpl($value, $cast, t);
}
