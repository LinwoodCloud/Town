import 'dart:typed_data';

import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/bloc/editor.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix_api/setonix_api.dart';

class TexturesEditorPage extends StatelessWidget {
  const TexturesEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditorCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: LeapBreakpoints.expanded),
            padding: const EdgeInsets.all(4),
            child: BlocBuilder<EditorCubit, SetonixData>(
              builder: (context, state) {
                return _TexturesColumn(
                  textures: state.getTexturesData(),
                  onRemove: (texture) => cubit.removeTexture(texture),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          const imageTypeGroup = fs.XTypeGroup(
            label: 'Images',
            extensions: <String>['png', 'jpg', 'jpeg', 'gif'],
            mimeTypes: <String>['image/png', 'image/jpeg', 'image/gif'],
            uniformTypeIdentifiers: <String>['public.png', 'public.jpeg'],
          );
          final data = await fs.openFile(acceptedTypeGroups: [
            imageTypeGroup,
          ]);
          if (data == null) return;
          final bytes = await data.readAsBytes();
          if (!context.mounted) return;
          final name = await showDialog<String>(
              context: context,
              builder: (context) => NameDialog(
                    value: data.name,
                    validator: defaultNameValidator(
                        context, cubit.state.getTextures().toList()),
                  ));
          if (name == null) return;
          cubit.setTexture(name, bytes);
        },
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(PhosphorIconsLight.plus),
      ),
    );
  }
}

class EditorTextureListTile extends StatelessWidget {
  final String? label;
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback? onRemove;

  const EditorTextureListTile({
    super.key,
    this.label,
    required this.value,
    required this.onChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorCubit, SetonixData>(
      builder: (context, state) {
        final data = state.getTexture(value);
        return ListTile(
          title: Text(label ?? AppLocalizations.of(context).texture),
          subtitle:
              Text(value.isEmpty ? AppLocalizations.of(context).notSet : ''),
          leading:
              data == null ? null : Image.memory(data, width: 48, height: 48),
          onTap: () => showDialog(
            context: context,
            builder: (context) =>
                TextureDialog(textures: state.getTexturesData()),
          ).then((texture) {
            if (texture == null) return;
            onChanged(texture);
          }),
          trailing: onRemove == null
              ? null
              : IconButton(
                  icon: const Icon(PhosphorIconsLight.trash),
                  onPressed: onRemove,
                ),
        );
      },
    );
  }
}

class TextureDialog extends StatelessWidget {
  final Map<String, Uint8List?> textures;

  const TextureDialog({
    super.key,
    required this.textures,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).textures),
      scrollable: true,
      content: _TexturesColumn(
          textures: textures,
          onClick: (texture) => Navigator.of(context).pop(texture)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}

class _TexturesColumn extends StatelessWidget {
  final Map<String, Uint8List?> textures;
  final void Function(String)? onClick;
  final void Function(String)? onRemove;

  const _TexturesColumn({
    required this.textures,
    this.onClick,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: textures.entries.map((entry) {
        final texture = entry.key;
        final data = entry.value;
        final tile = ListTile(
          title: Text(texture),
          leading:
              data == null ? null : Image.memory(data, width: 48, height: 48),
          trailing: onRemove == null
              ? null
              : IconButton(
                  icon: const Icon(PhosphorIconsLight.trash),
                  onPressed: () => onRemove!(texture),
                ),
          onTap: onClick == null ? null : () => onClick!(texture),
        );
        if (onRemove == null) return tile;
        return Dismissible(
          key: ValueKey(texture),
          onDismissed: (direction) => onRemove!(texture),
          child: tile,
        );
      }).toList(),
    );
  }
}

class VisualEditingView<T extends VisualDefinition> extends StatelessWidget {
  final T value;
  final ValueChanged<T> onChanged;

  const VisualEditingView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = value.size;
    return Column(
      children: [
        EditorTextureListTile(
          value: value.texture,
          onChanged: (texture) =>
              onChanged(value.copyWith(texture: texture) as T),
          onRemove: value.texture.isEmpty
              ? null
              : () => onChanged(value.copyWith(texture: '') as T),
        ),
        OffsetListTile(
          value: value.offset.toOffset(),
          title: Text(AppLocalizations.of(context).offset),
          fractionDigits: 0,
          onChanged: (offset) =>
              onChanged(value.copyWith(offset: offset.toDefinition()) as T),
        ),
        const SizedBox(height: 4),
        size == null
            ? ListTile(
                title: Text(AppLocalizations.of(context).size),
                subtitle:
                    Text(AppLocalizations.of(context).wholeSizeClickCustomize),
                onTap: () =>
                    onChanged(value.copyWith(size: VectorDefinition.one) as T),
              )
            : OffsetListTile(
                value: size.toOffset(),
                title: Text(AppLocalizations.of(context).size),
                fractionDigits: 0,
                onChanged: (offset) => onChanged(
                    value.copyWith(offset: offset.toDefinition()) as T),
                trailing: IconButton(
                  tooltip: AppLocalizations.of(context).clear,
                  icon: const Icon(PhosphorIconsLight.x),
                  onPressed: () => onChanged(value.copyWith(size: null) as T),
                ),
              ),
      ],
    );
  }
}
