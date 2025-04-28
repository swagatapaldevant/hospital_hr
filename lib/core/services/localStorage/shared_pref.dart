import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  SharedPref();

  // for user name
  void setUserName(String userName);
  Future<String?> getUserName();

  // for profile image
  void setProfileImage(String profileImage);
  Future<String?> getProfileImage();

// for authentication token
  void setUserAuthToken(String authToken);
  Future<String> getUserAuthToken();









  // for institute id
  void setInstituteId(String id);
  Future<String?>getInstituteId();

  // for login or not
  void setLoginStatus(bool status);
  Future<bool> getLoginStatus();



  // for candidate id
  void setCandidateId(String candidateId);
  Future<String?> getCandidateId();

  // for school name
  void setSchoolName(String schoolName);
  Future<String?> getSchoolName();

  // for name(teacher/student/parent)


  // for userType(teacher/student/parent)
  void setUserType(String userType);
  Future<String> getUserType();

  // store children list
  void setChildrenList(Map<String, String> childrenList);
  Future<Map<String, String>> getChildrenList();

  // store children count
  void setChildrenCount(String childrenCount);
  Future<String?> getChildrenCount();

  void clearOnLogout();





  void setPremimumStatus(bool status);
  Future<bool> getPremimumStatus();

  void setUserId(int rollId);
  Future<int> getUserId();

  void setAddress(String token);
  Future<String> getAddress();


  void setOccupation(String token);
  Future<String> getOccupation();



  void setPhoneCode(String data);

  Future<String> getPhoneCode();

  void setGender(String data);

  Future<String> getGender();

  void setName(String data);
  Future<String> getName();

  void setEmail(String data);
  Future<String> getEmail();


  void setPhone(String data);
  Future<String> getPhone();




}