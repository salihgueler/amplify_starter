import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) {
  print('Flutter pub get is called.');
  final result = Process.runSync(
    'flutter',
    ['pub', 'get'],
    workingDirectory: '{{project_name}}',
  );
  print('Flutter pub get successfully finished ${result.exitCode}.');

  print('Initializing Amplify please wait.');
  final amplifyResult = Process.runSync(
    'amplify',
    ['init', '--yes'],
    workingDirectory: '{{project_name}}',
  );
  print('Project is initialized. ${amplifyResult.exitCode}');

  print('amplify auth is called on file.');

  print('1. cat operation started');

  final executeResult = Process.runSync(
    'cat',
    ['add_auth_request.json'],
    workingDirectory: '{{project_name}}',
  );

  print('1. cat operation finished');
  print('cat is added ${executeResult.exitCode}.');
  print('cat is added ${executeResult.stderr}.');

  print('2 Amplify auth is called');
  final authResult = Process.runSync(
    'amplify',
    ['add', 'auth', '--headless'],
    workingDirectory: '{{project_name}}',
  );

  print('Auth is added ${authResult.exitCode}.');
  print('Auth is added ${authResult.stderr}.');
}
