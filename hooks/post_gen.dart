import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runFlutterPubGet(context);

  await _runAmplifyInit(context);
}

Future<void> _runFlutterPubGet(HookContext context) async {
  final flutterPubGetProgress = context.logger.progress(
    'running "flutter pub get"',
  );
  final result = await Process.start(
    'flutter',
    ['pub', 'get'],
    workingDirectory: context.vars['project_name'],
  );

  final exitCode = await result.exitCode;

  if (exitCode == 0) {
    flutterPubGetProgress.complete('Flutter pub get successfully finished.');
  } else {
    final errorBytes = await result.stderr.first;
    final error = systemEncoding.decode(errorBytes);
    flutterPubGetProgress.complete(
      'Flutter pub get had an error $error.',
    );
    exit(exitCode);
  }
}

Future<void> _runAmplifyInit(HookContext context) async {
  final amplifyInitProgress = context.logger.progress(
    'running "amplify init --yes"',
  );

  final result = await Process.start(
    'amplify',
    ['init', '--yes'],
    workingDirectory: context.vars['project_name'],
    mode: ProcessStartMode.inheritStdio,
  );

  // Complete progress so it doesn't interfere with stdout of `amplify`
  amplifyInitProgress.complete();

  final exitCode = await result.exitCode;

  if (exitCode == 0) {
    context.logger.success('Project is initialized.');
  } else {
    context.logger.err('Project initialization failed.');
    exit(exitCode);
  }
}