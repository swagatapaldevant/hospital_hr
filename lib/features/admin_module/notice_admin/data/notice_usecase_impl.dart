
import 'package:hospital_hr/core/network/apiClientRepository/api_client.dart';
import 'package:hospital_hr/core/network/apiHelper/api_endpoint.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';

class NoticeUsecaseImpl extends NoticeUsecase{
  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> noticeList({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Resource resource =
    await _apiClient.getRequest(url:ApiEndPoint.noticeList,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }

  @override
  Future<Resource> addNotice({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization": "Bearer $token",
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.addNotice,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


}

