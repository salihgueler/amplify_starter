import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'amplifyconfiguration.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  try {
    await _configureAmplify();
  } on Exception catch(exception) {
    log(exception.toString());
  }
  
  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

Future<void> _configureAmplify() async {
  // TODO: Add your Amplify library definitions here e.g.:
  // final auth = AmplifyAuthCognito();
  // await Amplify.addPlugins([
  //   auth,
  // ]);
  await Amplify.configure(amplifyconfig);
}