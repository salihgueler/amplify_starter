import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  _runFlutterPubGet(context);

  _runAmplifyInit(context);

  _runAmplifyAddAuth(context);

  _runAmplifyAddApi(context);

  _runAmplifyCodegen(context);

  stdout.writeln("Do you want to push your changes to the cloud now?");
  stdout.write(
    "This might take couple of minutes (between 5-10 minutes) and you can do it any time by running 'amplify push': (Y/n)",
  );
  final input = stdin.readLineSync() ?? '';

  _runAmplifyPush(context, input);
}

Future<void> _runFlutterPubGet(HookContext context) async {
  final flutterPubGetProgress = context.logger.progress(
    'running "flutter pub get"',
  );
  final result = await Process.start(
    'flutter',
    ['pub', 'get'],
    workingDirectory: '{{project_name}}',
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
    workingDirectory: '{{project_name}}',
  );

  final exitCode = await result.exitCode;

  if (exitCode == 0) {
    amplifyInitProgress.complete('Project is initialized.');
  } else {
    final errorBytes = await result.stderr.first;
    final error = systemEncoding.decode(errorBytes);
    amplifyInitProgress.complete('Project initialization failed. $error');
    exit(exitCode);
  }
}

Future<void> _runAmplifyAddAuth(HookContext context) async {
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

  if (exitCode == 0) {
    amplifyAddProgress.complete('Amplify Auth added.');
  } else {
    final errorBytes = await amplifyAddAuth.stderr.first;
    final error = systemEncoding.decode(errorBytes);
    amplifyAddProgress.complete('Amplify Auth failed to be added. $error');
    exit(exitCode);
  }
}

Future<void> _runAmplifyAddApi(HookContext context) async {
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

  if (exitCodeApi == 0) {
    amplifyApiProgress.complete('Amplify API added.');
  } else {
    final errorBytes = await amplifyAddApi.stderr.first;
    final error = systemEncoding.decode(errorBytes);
    amplifyApiProgress.complete('Amplify API failed to be added. $error');
    exit(exitCodeApi);
  }
}

Future<void> _runAmplifyCodegen(HookContext context) async {
  final amplifyCodegenProgress = context.logger.progress(
    'running "amplify codegen models"',
  );

  final result = await Process.start(
    'amplify',
    ['codegen', 'models'],
    workingDirectory: '{{project_name}}',
  );

  final exitCode = await result.exitCode;

  if (exitCode == 0) {
    amplifyCodegenProgress.complete(
      'Models are created.',
    );
  } else {
    final errorBytes = await result.stderr.first;
    final error = systemEncoding.decode(errorBytes);
    amplifyCodegenProgress.complete('Model creation failed. $error');
    exit(exitCode);
  }
}

Future<void> _runAmplifyPush(HookContext context, String input) async {
  if (input.isEmpty || input == 'Y' || input == 'y') {
    stdout.writeln(
      '\nRunning "amplify push", do not close the terminal until it is finished.',
    );

    final amplifyPushProgress = context.logger.progress(
      'running "amplify push"',
    );

    final result = Process.runSync(
      'amplify',
      ['push', '--yes'],
      workingDirectory: '{{project_name}}',
    );

    final exitCode = await result.exitCode;

    if (exitCode == 0) {
      amplifyPushProgress.complete('Backend is pushed');
    } else {
      final errorBytes = await result.stderr.first;
      final error = systemEncoding.decode(errorBytes);
      amplifyPushProgress.complete('Backend push is failed. $error');
      exit(exitCode);
    }
  } else {
    stdout.writeln(
      'Do not forget to push your changes to the cloud by running "amplify push"',
    );
  }
}
