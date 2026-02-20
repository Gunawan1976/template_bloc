import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';

// Import semua file BLoC, UseCase, Repo, dan Service Anda
import 'package:vcc_remake_bloc/features/auth/login/data/implements/login_repository_implements.dart';
import 'package:vcc_remake_bloc/features/auth/login/data/sources/login_api_services.dart';
import 'package:vcc_remake_bloc/features/auth/login/domain/usecases/login_usecases.dart';
import 'package:vcc_remake_bloc/features/auth/login/domain/usecases/profile_usecase.dart';
import 'package:vcc_remake_bloc/features/detail_produk/data/implements/single_produk_repository_implements.dart';
import 'package:vcc_remake_bloc/features/detail_produk/data/sources/single_produk_api_services.dart';
import 'package:vcc_remake_bloc/features/detail_produk/domain/repositories/single_produk_repositories.dart';
import 'package:vcc_remake_bloc/features/home_page/data/implements/home_repository_implements.dart';
import 'package:vcc_remake_bloc/features/home_page/data/sources/home_api_services.dart';
import 'package:vcc_remake_bloc/features/home_page/domain/repositories/home_repositories.dart';
import 'package:vcc_remake_bloc/features/home_page/domain/use_cases/produk_usecase.dart';
import '../../features/auth/login/domain/repositories/login_repositories.dart';
import '../../features/detail_produk/domain/use_cases/single_produk_usecase.dart';
import '../constant.dart';
import 'logging_interceptor.dart';

final locator = GetIt.instance;

/// Fungsi setup tunggal untuk DI

Future<void> setupLocator() async {

  final dio = await _createDio();

  // Register dependencies
  // locator.registerLazySingleton<PersistCookieJar>(() => cookieJar);
  locator.registerLazySingleton<Dio>(() => dio);
  locator.registerLazySingleton<LoggingInterceptors>(
        () => LoggingInterceptors(dio: dio),
  );

  setupDependencies();
}

Future<Dio> _createDio() async {
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

  dio.interceptors.add(LoggingInterceptors(dio: dio,));

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

  locator.registerLazySingleton(
        () => GetProfileUseCase(locator<LoginRepository>()),
  );

  // Presentation


  ///GetProduk
  locator.registerLazySingleton<HomeApiServices>(
        () => HomeApiServiceImpl(locator<Dio>()), // Pastikan ServiceImpl mengambil Dio
  );

  locator.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImp(homeApiServices:  locator<HomeApiServices>()),
  );

  // Domain
  locator.registerLazySingleton(
        () => GetProdukUseCase(locator<HomeRepository>()),
  );

  // Presentation


  ///GetSingleProduk
  locator.registerLazySingleton<SingleProdukApiServices>(
        () => SingleProdukApiServiceImpl(locator<Dio>()), // Pastikan ServiceImpl mengambil Dio
  );

  locator.registerLazySingleton<SingleProdukRepository>(
        () => SingleProdukRepositoryImpl(singleProdukApiServices: locator<SingleProdukApiServices>()),
  );

  // Domain
  locator.registerLazySingleton(
        () => GetSingleGetProdukUseCase(locator<SingleProdukRepository>()),
  );

  // Presentation

}