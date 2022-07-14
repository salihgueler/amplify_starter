import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) {
  final result = Process.runSync(
    'which',
    ['amplify'],
  );
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }
}
