
import 'package:hospital_hr/core/network/apiClientRepository/api_client.dart';
import 'package:hospital_hr/core/network/apiHelper/api_endpoint.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/data/auth_usecase.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase.dart';

class EventsAdminUsecaseImpl extends EventsAdminUsecase{
  final ApiClient _apiClient = getIt<ApiClient>();
  final SharedPref _pref = getIt<SharedPref>();


  @override
  Future<Resource> eventList({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization":"Bearer $token",
    };
    Resource resource =
    await _apiClient.getRequest(url:ApiEndPoint.eventListApi,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


  @override
  Future<Resource> addEvent({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization":"Bearer $token",
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.addEvent,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


  @override
  Future<Resource> getEventDetails({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization":"Bearer $token",
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.getEventDetails,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }


  @override
  Future<Resource> updateEventDetails({required Map<String, dynamic> requestData}) async {

    String token = await _pref.getUserAuthToken();
    Map<String, String> header = {
      "Authorization":"Bearer $token",
    };
    Resource resource =
    await _apiClient.postRequest(url:ApiEndPoint.updateEventDetails,header: header, requestData:requestData );
    if (resource.status == STATUS.SUCCESS) {
      return resource;

    } else {
      return resource;
    }

  }



}

