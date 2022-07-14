import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) {
  print('Flutter pub get is called.');
  final result = Process.runSync(
    'flutter',
    ['pub', 'get'],
    workingDirectory: 'Amplify Starter',
  );
  print('Flutter pub get successfully finished ${result.exitCode}.');

  print('Initializing Amplify please wait.');
  Process.runSync(
    'amplify',
    ['init', '--yes'],
    workingDirectory: 'Amplify Starter',
  );
  print('Project is initialized.');
  print('Adding GraphQL API.');
  final grapQlResult = Process.runSync(
    'cat',
    ['auth_information.json | amplify add api --headless'],
    workingDirectory: 'Amplify Starter',
  );
  print('GraphQL API is added. ${grapQlResult.exitCode}');
}
