import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class CustomBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('onEvent $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.i('onChange $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('onTransition $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('onError $error');
  }
}
