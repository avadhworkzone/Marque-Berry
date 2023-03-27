import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:socialv/auth/auth_service.dart';
import 'package:socialv/auth/credentials_storage.dart';
import 'package:socialv/auth/cubit/auth_cubit.dart';
import 'package:socialv/network/api_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(baseUrl: 'http://52.66.136.133:8081'),
    ),
  );
  sl.registerLazySingleton<CredentialsStorage>(
    () => CredentialsStorage(
      FlutterSecureStorage(),
    ),
  );
  sl.registerLazySingleton<ApiService>(
    () => ApiService(sl()),
  );
  sl.registerLazySingleton<AuthService>(
    () => AuthService(sl(), sl()),
  );
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(sl()),
  );
}
