
import 'package:hospital_hr/core/network/apiClientRepository/api_client.dart';
import 'package:hospital_hr/core/network/apiHelper/api_endpoint.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/data/auth_usecase.dart';
import 'package:hospital_hr/features/admin_module/users/data/users_usecase.dart';

class UsersUseCaseImpl extends UsersUseCase{
  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> userList({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Resource resource =
    await _apiClient.getRequest(url:ApiEndPoint.userList,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


  @override
  Future<Resource> userDetails({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.userDetails,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


  @override
  Future<Resource> updateStatus({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.userActiveStatus,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


}

