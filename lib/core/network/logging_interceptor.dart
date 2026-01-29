// Ganti seluruh file logging_interceptor.dart Anda dengan ini

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/core/network/token_cache.dart';
// import 'package:get/get.dart' as g;

// Pastikan semua path import ini benar
import '../constant.dart';
import '../utils/secure_storage_util.dart';
import '../utils/util_helper.dart';

class LoggingInterceptors extends Interceptor {
  final Dio dio;
  final PersistCookieJar cookieJar;
  bool _isRefreshingToken = false;

  LoggingInterceptors({
    required this.dio,
    required this.cookieJar,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept'] = 'application/json';
    options.headers['X-IS-MOBILE'] = 'true';

    // print("--> ${options.method.toUpperCase()} ${options.uri}");
    // options.headers.forEach((k, v) => print('$k: $v'));
    // if (options.data != null) print("Body: ${options.data}");
    // print("--> END ${options.method}");

    // Refresh CSRF token for POST requests
    if (options.method == 'POST' && !_isRefreshingToken) {
      try {
        await _refreshCsrfToken();
      } catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Failed to get CSRF token: $e',
          ),
        );
      }
    }

    if (!_shouldSkipAuthHeaders(options.path)) {
      options.headers['X-CSRF-TOKEN'] = TokenCache.csrfToken;
    }

    handler.next(options);
  }

  bool _shouldSkipAuthHeaders(String path) {
    const excludedPaths = ["auth/auth-check", "captcha/get"];
    return excludedPaths.contains(path);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 0;
    String errorMessage = "Terjadi kesalahan"; // Pesan default

    if (err.response?.data is Map) {
      final data = err.response!.data as Map;
      errorMessage = data['message'] ?? data['messages'] ?? "Terjadi kesalahan";
    }

    // g.Get.snackbar(
    //   "Notifikasi",
    //   UtilsHelper.translateMessage(errorMessage), // <-- Gunakan variabel yang aman
    //   backgroundColor: Colors.red,
    //   colorText: Colors.white,
    // );
    if (statusCode == 401 || statusCode == 403) {
      _handleSessionExpired();
    } else if (_isUserBlocked(err)) {
      _handleUserBlocked(err);
    }

    super.onError(err, handler);
  }

  bool _isUserBlocked(DioException err) {
    if (err.response?.data is Map) {
      final data = err.response!.data as Map;
      final msg = data['message'] ?? data['messages'];
      return msg == "user_blocked" || msg == "ip_blocked" || msg == "country_blocked";
    }
    return false;
  }

  void _handleSessionExpired() {
    // if (g.Get.isDialogOpen == false) {
    //   g.Get.defaultDialog(
    //     barrierDismissible: false,
    //     radius: 8,
    //     titlePadding: EdgeInsets.symmetric(vertical: 12.sp),
    //     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    //     middleTextStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
    //     titleStyle: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w600),
    //     buttonColor: HexColor(Constant.appMaincolor),
    //     confirmTextColor: Colors.white,
    //     title: 'Sesi berakhir',
    //     middleText: 'Sesi telah berakhir,\nsilakan login kembali',
    //     textConfirm: 'Login',
    //     onConfirm: () async {
    //       await LoginApiServiceImpl().logout();
    //       await clearUserSession();
    //       g.Get.offAll(() => PreLoginPage());
    //     },
    //   );
    // }
  }

  void _handleUserBlocked(DioException err) {
    // if (g.Get.isDialogOpen == false) {
    //   g.Get.defaultDialog(
    //     barrierDismissible: false,
    //     radius: 8,
    //     titlePadding: EdgeInsets.symmetric(vertical: 12.sp),
    //     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    //     middleTextStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
    //     titleStyle: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w600),
    //     buttonColor: HexColor(Constant.appMaincolor),
    //     confirmTextColor: Colors.white,
    //     title: (err.response?.data is Map)
    //         ? UtilsHelper.translateMessage(err.response!.data['message'])
    //         : "Akses Diblokir",
    //     middleText: 'User anda telah di blokir,\nsilakan hubungi admin',
    //     textConfirm: 'Exit',
    //     onConfirm: () async {
    //       await LoginApiServiceImpl().logout();
    //       await clearUserSession();
    //       g.Get.offAll(() => PreLoginPage());
    //       SystemNavigator.pop();
    //     },
    //   );
    // }
  }

  Future<void> clearUserSession() async {
    await UserSecureStorage.deleteField(Constant.levelUser);
    await UserSecureStorage.deleteField(Constant.unitCode);
    await UserSecureStorage.deleteField(Constant.CSRF_TOKEN);
    await UserSecureStorage.deleteField(Constant.RESPONSE_CSRF_TOKEN);
    await UserSecureStorage.deleteField(Constant.CSRF_TOKEN_LOGIN);
    await UserSecureStorage.deleteField(Constant.DATA_USER);
    await cookieJar.deleteAll();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print("<-- ${response.statusCode} ${response.realUri}");
    // response.headers.forEach((k, v) => print('$k: $v'));
    // print("Response: ${response.data}");
    super.onResponse(response, handler);
  }

  Future<void> _refreshCsrfToken() async {
    if (_isRefreshingToken) return;
    _isRefreshingToken = true;

    try {
      dio.options.baseUrl = Constant.BASE_URL;
      dio.options.headers['Host'] =  Constant.HOST_URL;
      dio.options.headers['Referer'] = 'https://${Constant.HOST_URL}/';
      final response = await dio.get(
        'csrf-token',
        options: Options(responseType: ResponseType.plain,
        ),
      );

      final jsonData = json.decode(response.data);
      final tokenCsrf = jsonData['csrf_token']?.toString();

      final tokenLogin = await UserSecureStorage.getField(Constant.CSRF_TOKEN_LOGIN);
      await UserSecureStorage.setField(Constant.RESPONSE_CSRF_TOKEN, tokenCsrf ?? "");
      TokenCache.updateTokens(newCsrfToken: tokenCsrf, tokenLogin: tokenLogin);
    } catch (e) {
      // print("Error refresh CSRF token: $e");
    } finally {
      _isRefreshingToken = false;
    }
  }
}