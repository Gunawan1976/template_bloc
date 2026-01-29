import 'package:dio/dio.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/network/injection.dart';
import '../models/captcha_model.dart';

abstract class CaptchaApiService{
  Future<CaptchaModel>getCaptcha();
}

class CaptchaApiServiceImpl implements CaptchaApiService {
  final Dio dio;

  CaptchaApiServiceImpl([Dio? dio]) : dio = dio ?? locator<Dio>();

  @override
  Future<CaptchaModel> getCaptcha() async{
    try{
      dio.options.baseUrl = Constant.BASE_URL;
      dio.options.headers['Host'] =  Constant.HOST_URL;
      dio.options.headers['Referer'] = 'https://${Constant.HOST_URL}/';
      Response response = await dio.get("captcha/get");
      return CaptchaModel.fromJson(response.data);
    }on DioException catch (e){
      print("Error fetching captcha: ${e.message}");
      return CaptchaModel(
        message: e.response?.data['message'],
        status: e.response?.statusCode ?? 500,
        data: null,
      );
    }
  }
  
}