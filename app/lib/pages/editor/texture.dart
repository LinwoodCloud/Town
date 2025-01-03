import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix/widgets/offset.dart';
import 'package:setonix_api/setonix_api.dart';

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
