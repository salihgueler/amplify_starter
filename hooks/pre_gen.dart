import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final result = await Process.run('which', ['amplify']);
  if (result.exitCode != 0) {
    context.logger.err(result.stderr);
    exit(result.exitCode);
  }
}
