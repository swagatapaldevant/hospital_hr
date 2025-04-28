import 'package:hospital_hr/core/network/apiHelper/resource.dart';

abstract class AuthUseCase {
  Future<Resource> adminLogin({required Map<String, dynamic> requestData});
}
