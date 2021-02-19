import 'package:github_test/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:github_test/redux/app_reducers.dart';

Future<Store<AppState>> createStore() async {
  return Store(appReducer,
      initialState: AppState.initial(),
      distinct: true,
      middleware: [LoggingMiddleware.printer()]);
}
