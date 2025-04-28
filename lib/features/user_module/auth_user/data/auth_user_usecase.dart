import 'package:hospital_hr/core/network/apiHelper/resource.dart';

abstract class AuthUserUseCase {
  Future<Resource> userLogin({required Map<String, dynamic> requestData});
}
