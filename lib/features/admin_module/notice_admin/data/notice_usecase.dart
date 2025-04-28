import 'package:hospital_hr/core/network/apiHelper/resource.dart';

abstract class NoticeUsecase {
  Future<Resource> noticeList({required Map<String, dynamic> requestData});
}
