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

void _runFlutterPubGet(HookContext context) {
  final flutterPubGetProgress = context.logger.progress(
    'running "flutter pub get"',
  );
  final result = Process.runSync(
    'flutter',
    ['pub', 'get'],
    workingDirectory: '{{project_name}}',
  );

  if (result.exitCode == 0) {
    flutterPubGetProgress.complete('Flutter pub get successfully finished.');
  } else {
    flutterPubGetProgress.complete(
      'Flutter pub get had an error ${result.stderr}.',
    );
    exit(result.exitCode);
  }
}

void _runAmplifyInit(HookContext context) {
  final amplifyInitProgress = context.logger.progress(
    'running "amplify init --yes"',
  );

  final amplifyResult = Process.runSync(
    'amplify',
    ['init', '--yes'],
    workingDirectory: '{{project_name}}',
  );

  if (amplifyResult.exitCode == 0) {
    amplifyInitProgress.complete('Project is initialized.');
  } else {
    amplifyInitProgress.complete(
      'Project initialization failed. ${amplifyResult.stderr}',
    );
    exit(amplifyResult.exitCode);
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

void _runAmplifyCodegen(HookContext context) {
  final amplifyCodegenProgress = context.logger.progress(
    'running "amplify codegen models"',
  );

  final amplifyCodegenResult = Process.runSync(
    'amplify',
    ['codegen', 'models'],
    workingDirectory: '{{project_name}}',
  );

  if (amplifyCodegenResult.exitCode == 0) {
    amplifyCodegenProgress.complete(
      'Models are created.',
    );
  } else {
    amplifyCodegenProgress.complete(
      'Model creation failed. ${amplifyCodegenResult.stderr}',
    );
    exit(amplifyCodegenResult.exitCode);
  }
}

void _runAmplifyPush(HookContext context, String input) {
  if (input.isEmpty || input == 'Y' || input == 'y') {
    stdout.writeln(
      '\nRunning "amplify push", do not close the terminal until it is finished.',
    );
    final amplifyCodegenProgress = context.logger.progress(
      'running "amplify push"',
    );

    final amplifyCodegenResult = Process.runSync(
      'amplify',
      ['push', '--yes'],
      workingDirectory: '{{project_name}}',
    );

    amplifyCodegenProgress.complete(
      amplifyCodegenResult.exitCode == 0
          ? 'Backend is pushed.'
          : 'Something went wrong: ${amplifyCodegenResult.stderr}',
    );
  } else {
    stdout.writeln(
      'Do not forget to push your changes to the cloud by running "amplify push"',
    );
  }
}
