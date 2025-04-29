
class ApiEndPoint{

  static final ApiEndPoint _instance = ApiEndPoint._internal();

  factory ApiEndPoint(){
    return _instance;
  }

  ApiEndPoint._internal();

  //static const baseurl = "http://192.168.29.243:8001/api";
  static const baseurl = "http://192.168.29.106/rainbow_new";

  static const adminLogin =  "$baseurl/api/login";
  static const userList =  "$baseurl/api/user_list";
  static const userDetails =  "$baseurl/api/user_details";
  static const noticeList =  "$baseurl/api/notices";
  static const addNotice =  "$baseurl/api/save_notice";
  static const getNoticeDetails =  "$baseurl/api/edit_notice";
  static const updateNoticeDetails =  "$baseurl/api/update_notice";
  static const deleteNoticeApi =  "$baseurl/api/delete_notice";
  static const eventListApi =  "$baseurl/api/events";
  static const addEvent =  "$baseurl/api/save_event";
  static const getEventDetails =  "$baseurl/api/edit_event";
  static const updateEventDetails =  "$baseurl/api/update_event";
  static const userActiveStatus =  "$baseurl/api/user_active_deactive";


}