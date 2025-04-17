
class ApiEndPoint{

  static final ApiEndPoint _instance = ApiEndPoint._internal();

  factory ApiEndPoint(){
    return _instance;
  }

  ApiEndPoint._internal();

  //static const baseurl = "http://192.168.29.243:8001/api";
  static const baseurl = "https://www.anjanshastri.com";

  // for example

  static const test =  "$baseurl/api/galleries";
  static const test1 =  "$baseurl/api/chambers";


  // auth module

  static const register =  "$baseurl/api/register";
  static const login =  "$baseurl/api/login";
  static const sendOtp =  "$baseurl/api/send-otp";
  static const verifyOtp =  "$baseurl/api/verify-otp";
  static const newPasswordSet =  "$baseurl/api/forgot-password";


  static const rashifalList =  "$baseurl/api/rashifals";
  static const rashifalDetails =  "$baseurl/api/rashifal-info";
  static const achievementList =  "$baseurl/api/achievements";
  static const chambersList =  "$baseurl/api/chambers";
  static const servicesList =  "$baseurl/api/services";
  static const postsInfo =  "$baseurl/api/posts-info";
  static const galleryList =  "$baseurl/api/galleries";
  static const userDetails =  "$baseurl/api/user-info";
  static const updateProfile =  "$baseurl/api/update-profile";
  static const contactRequest =  "$baseurl/api/contact-request";

  static const  kundaliCreation='$baseurl/api/insert-kundli';
  static const  kundaliMatching='$baseurl/api/insert-matchings';
  static const  kundaliOrderList='$baseurl/api/get-kundli';
  static const  getNotification='$baseurl/api/notifications';
  static const  getStateDistrict='$baseurl/api/state-list';
  static const  createAppointment='$baseurl/api/appointment-info';
  static const  chambersDataList='$baseurl/api/chambers';
  static const  getAvailableSlots ='$baseurl/api/booking-schedule';
  static const  bookApointment ='$baseurl/api/booked-appointment';
  static const  payment ='$baseurl/api/pay-response';
  static const  checkoutApi ='$baseurl/api/checkout';
  static const  myAppointments ='$baseurl/api/my-appointments';







}