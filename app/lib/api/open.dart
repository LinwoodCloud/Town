import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/main.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix/services/file_system.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openReleaseNotes() {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'go.linwood.dev',
          pathSegments: ['setonix', applicationMinorVersion]),
      mode: LaunchMode.externalApplication);
}

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
    Uri(
        scheme: 'https',
        host: 'setonix.linwood.dev',
        fragment: fragment,
        pathSegments: ['docs', 'v1', ...pageLocation]),
  );
}

Future<void> importFile(
    BuildContext context, SetonixFileSystem fileSystem) async {
  final result = await fs.openFile(
    acceptedTypeGroups: [
      fs.XTypeGroup(
        label: AppLocalizations.of(context).packs,
        extensions: const ['stnx'],
        uniformTypeIdentifiers: const ['dev.linwood.setonix.pack'],
        mimeTypes: const ['application/octet-stream', 'application/zip'],
      )
    ],
  );
  if (result == null) return;
  final bytes = await result.readAsBytes();
  final data = SetonixFile(bytes);
  if (context.mounted) return importFileData(context, fileSystem, data);
}

Future<SetonixFile?> getCorePack() async => SetonixFile(
    (await rootBundle.load('assets/pack.stnx')).buffer.asUint8List(),
    kCorePackId);

Future<void> importFileData(BuildContext context, SetonixFileSystem fileSystem,
    SetonixFile file) async {
  final data = file.load();
  final metadata = data.getMetadataOrDefault();
  final type = metadata.type;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(switch (type) {
        FileType.pack => AppLocalizations.of(context).importPack,
        FileType.game => AppLocalizations.of(context).importGame,
        FileType.template => AppLocalizations.of(context).importTemplate,
      }),
      content: Text(switch (type) {
        FileType.pack => AppLocalizations.of(context).importPackDescription,
        FileType.game => AppLocalizations.of(context).importGameDescription,
        FileType.template =>
          AppLocalizations.of(context).importTemplateDescription,
      }),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(false),
          label: Text(AppLocalizations.of(context).cancel),
          icon: Icon(PhosphorIconsLight.prohibit),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          label: Text(AppLocalizations.of(context).import),
          icon: Icon(PhosphorIconsLight.boxArrowDown),
        ),
      ],
    ),
  );
  if (!(result ?? false)) return;
  final namespace = metadata.id;
  switch (type) {
    case FileType.pack:
      await fileSystem.packSystem.updateFile(namespace, file);
    case FileType.template:
      await fileSystem.templateSystem.updateFile(namespace, data);
    case FileType.game:
      await fileSystem.worldSystem.createFile(metadata.name, data);
  }
}
