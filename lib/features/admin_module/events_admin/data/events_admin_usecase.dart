import 'package:hospital_hr/core/network/apiHelper/resource.dart';

abstract class EventsAdminUsecase {
  Future<Resource> eventList({required Map<String, dynamic> requestData});
}
