
import 'package:get_it/get_it.dart';
import 'package:hospital_hr/core/network/apiClientRepository/api_client.dart';
import 'package:hospital_hr/core/network/apiClientRepository/api_client_impl.dart';
import 'package:hospital_hr/core/network/networkRepository/network_client.dart';
import 'package:hospital_hr/core/network/networkRepository/network_client_impl.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref_impl.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/data/auth_usecase.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/data/auth_usecase_impl.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase_impl.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase_impl.dart';
import 'package:hospital_hr/features/admin_module/users/data/users_usecase.dart';
import 'package:hospital_hr/features/admin_module/users/data/users_usecase_impl.dart';

import '../../../features/user_module/auth_user/data/auth_user_usecase.dart';
import '../../../features/user_module/auth_user/data/auth_user_usecase_impl.dart';


final getIt = GetIt.instance;

void initializeDependency(){

  getIt.registerFactory<NetworkClient>(()=> NetworkClientImpl());
  getIt.registerFactory<SharedPref>(()=>SharedPrefImpl());
  getIt.registerFactory<ApiClient>(()=> ApiClientImpl());
  getIt.registerFactory<AuthUseCase>(()=> AuthUseCaseImpl());
  getIt.registerFactory<UsersUseCase>(()=> UsersUseCaseImpl());
  getIt.registerFactory<NoticeUsecase>(()=> NoticeUsecaseImpl());
  getIt.registerFactory<AuthUserUseCase>(()=> AuthUserUseCaseImpl());
  getIt.registerFactory<EventsAdminUsecase>(()=> EventsAdminUsecaseImpl());








}