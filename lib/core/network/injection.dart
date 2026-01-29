import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vcc_remake_bloc/core/utils/aes_gcm.dart';

// Import semua file BLoC, UseCase, Repo, dan Service Anda
import 'package:vcc_remake_bloc/features/auth/captcha/data/implements/captcha_implements.dart';
import 'package:vcc_remake_bloc/features/auth/captcha/data/sources/captcha_api_service.dart';
import 'package:vcc_remake_bloc/features/auth/captcha/domain/repositories/captcha_repositories.dart';
import 'package:vcc_remake_bloc/features/auth/captcha/domain/use_cases/captcha_usecase.dart';
import 'package:vcc_remake_bloc/features/auth/captcha/presentation/bloc/captcha_bloc.dart';
import 'package:vcc_remake_bloc/features/auth/login/data/implements/login_repository_implements.dart';
import 'package:vcc_remake_bloc/features/auth/login/data/sources/login_api_services.dart';
import 'package:vcc_remake_bloc/features/auth/login/domain/usecases/login_usecases.dart';
import '../../features/auth/login/domain/repositories/login_repositories.dart';
import '../../features/auth/login/presentation/bloc/login_bloc.dart';
import '../constant.dart';
import 'logging_interceptor.dart';

final locator = GetIt.instance;

/// Fungsi setup tunggal untuk DI
///
Future<void> setupLocator() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final cookieJar = PersistCookieJar(
    storage: FileStorage('${appDocDir.path}/.cookies/'),
  );

  final dio = await _createDio(cookieJar);

  // Register dependencies
  locator.registerLazySingleton<PersistCookieJar>(() => cookieJar);
  locator.registerLazySingleton<Dio>(() => dio);
  locator.registerLazySingleton<LoggingInterceptors>(
        () => LoggingInterceptors(dio: dio, cookieJar: cookieJar),
  );

  setupDependencies();
}

Future<Dio> _createDio(PersistCookieJar cookieJar) async {
  final options = BaseOptions(
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    baseUrl: Constant.BASE_URL,
  );

  final dio = Dio(options);

  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient(context: SecurityContext(withTrustedRoots: false));
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    },
    validateCertificate: (certificate, host, port) => true,
  );

  dio.interceptors.add(LoggingInterceptors(dio: dio, cookieJar: cookieJar));

  dio.interceptors.add(CookieManager(cookieJar));

  // dio.interceptors.add(ChuckerDioInterceptor());

  if (kReleaseMode) {
    dio.interceptors.add(
      CertificatePinningInterceptor(
        allowedSHAFingerprints: [Constant.CERT_SHA256_FINGERPRINT],
      ),
    );
  }

  return dio;
}

Future<void> setupDependencies() async {
  // --- Daftarkan Fitur Login ---

  // Data
  locator.registerLazySingleton<LoginApiServices>(
        () => LoginApiServiceImpl(locator<Dio>()), // Pastikan ServiceImpl mengambil Dio
  );
  locator.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImp(loginApiService: locator<LoginApiServices>()),
  );

  // Domain
  locator.registerLazySingleton(
        () => LoginUseCase(locator<LoginRepository>()),
  );

  // Presentation
  locator.registerFactory<LoginBloc>(
        () => LoginBloc(locator<LoginUseCase>()),
  );

  // --- Daftarkan Fitur Captcha ---

  // Data
  locator.registerLazySingleton<CaptchaApiService>(
        () => CaptchaApiServiceImpl(locator<Dio>()), // Pastikan ServiceImpl mengambil Dio
  );
  locator.registerLazySingleton<CaptchaRepository>(
        () => CaptchaRepositoryImpl(apiService: locator<CaptchaApiService>()),
  );

  // Domain
  locator.registerLazySingleton(
        () => CaptchaUsecase(locator<CaptchaRepository>()),
  );

  // Presentation
  locator.registerFactory<CaptchaBloc>(
        () => CaptchaBloc(locator<CaptchaUsecase>())
  );
}