import 'package:get_it/get_it.dart';
import 'package:mymy_m1/services/authentication/auth_service.dart';
import 'package:mymy_m1/services/authentication/user_session.dart';
import 'package:mymy_m1/utils/logger/logger_tool.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  _setupAuth();
  _setupLogger();
}

void _setupAuth() {
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => UserSession(getIt<AuthService>()));
}

void _setupLogger() {
  getIt.registerLazySingleton(() => LoggerTool());
}
