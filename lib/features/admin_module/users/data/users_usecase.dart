import 'package:hospital_hr/core/network/apiHelper/resource.dart';

abstract class UsersUseCase {
  Future<Resource> userList({required Map<String, dynamic> requestData});
  Future<Resource> userDetails({required Map<String, dynamic> requestData});
  Future<Resource> updateStatus({required Map<String, dynamic> requestData});
}
