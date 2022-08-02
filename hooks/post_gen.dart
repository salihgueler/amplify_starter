
import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final flutterPubGetProgress = context.logger.progress(
    'running "flutter pub get"',
  );
  final result = Process.runSync(
    'flutter',
    ['pub', 'get'],
    workingDirectory: '{{project_name}}',
  );

  flutterPubGetProgress.complete(
    'Flutter pub get successfully finished ${result.exitCode}.',
  );

  final amplifyInitProgress = context.logger.progress(
    'running "amplify init --yes"',
  );

  final amplifyResult = Process.runSync(
    'amplify',
    ['init', '--yes'],
    workingDirectory: '{{project_name}}',
  );

  amplifyInitProgress.complete(
    'Project is initialized. ${amplifyResult.exitCode}',
  );

  final amplifyAddProgress = context.logger.progress(
    'running "amplify add auth --headless"',
  );

  final catAddAuthRequest = await Process.start(
    'cat',
    ['add_auth_request.json'],
    workingDirectory: '{{project_name}}',
  );

  final amplifyAddAuth = await Process.start(
    'amplify',
    ['add', 'auth', '--headless'],
    workingDirectory: '{{project_name}}',
  );

  catAddAuthRequest.stdout.pipe(amplifyAddAuth.stdin);

  await amplifyAddAuth.stdout.pipe(stdout);
  final exitCode = await amplifyAddAuth.exitCode;
  amplifyAddProgress.complete('Added amplify auth $exitCode');
}
