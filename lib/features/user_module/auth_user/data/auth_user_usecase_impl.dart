
import 'package:hospital_hr/core/network/apiClientRepository/api_client.dart';
import 'package:hospital_hr/core/network/apiHelper/api_endpoint.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/data/auth_usecase.dart';
import 'package:hospital_hr/features/user_module/auth_user/data/auth_user_usecase.dart';

class AuthUserUseCaseImpl extends AuthUserUseCase{
  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> userLogin({required Map<String, dynamic> requestData}) async {

    //String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      //"Authorization": token,
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.adminLogin,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


}

