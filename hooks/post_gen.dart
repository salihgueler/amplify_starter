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

  await catAddAuthRequest.stdout.pipe(amplifyAddAuth.stdin);

  final exitCode = await amplifyAddAuth.exitCode;
  amplifyAddProgress.complete('Added amplify auth $exitCode');

  final amplifyApiProgress = context.logger.progress(
    'running "amplify add api --headless"',
  );

  final catAddApiRequest = await Process.start(
    'cat',
    ['add_api_request.json'],
    workingDirectory: '{{project_name}}',
  );

  final amplifyAddApi = await Process.start(
    'amplify',
    ['add', 'api', '--headless'],
    workingDirectory: '{{project_name}}',
  );

  await catAddApiRequest.stdout.pipe(amplifyAddApi.stdin);

  final exitCodeApi = await amplifyAddApi.exitCode;
  final event = await amplifyAddApi.stderr.first;
  final decoded = systemEncoding.decode(event);

  amplifyApiProgress.complete('Added amplify api $decoded');
}
