import 'package:hospital_hr/core/network/apiHelper/resource.dart';

abstract class EventsAdminUsecase {
  Future<Resource> eventList({required Map<String, dynamic> requestData});
  Future<Resource> addEvent({required Map<String, dynamic> requestData});
  Future<Resource> getEventDetails({required Map<String, dynamic> requestData});
  Future<Resource> updateEventDetails({required Map<String, dynamic> requestData});
}
