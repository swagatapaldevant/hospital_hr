import 'dart:convert';

import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefImpl extends SharedPref {


  final String _instituteId = "Institute Id";
  final String _loginStatus = "loginStatus";
  final String _candidateId = "candidate id";
  final String _schoolName = "school name";
  final String _userName = "user name";
  final String _userType = "user type";
  final String _childrenListKey = "childrenList";
  final String _childrenCount = "childrenCount";




  final String _userId = "userId";
  final String _Address = "Address";
  final String _Occupation = "Occupation";
  final String _userAuthToken = "userAuthToken";
  final String _phoneCode = "phoneCode";
  final String _userAge = "userAge";
  final String _phoneNumber = "phoneNumber";
  final String _emailId = "emailId";
  final String _profileImage = "profileImg";
  final String _premimumStatus = "PremimumStatus";



  @override
  Future<String> getUserName() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userName) ?? "";
  }

  @override
  void setUserName(String userName) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userName, userName);
  }


  @override
  Future<String> getProfileImage() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_profileImage) ?? "";
  }

  @override
  void setProfileImage(String profileImage) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_profileImage, profileImage);
  }


  @override
  Future<String> getUserAuthToken() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userAuthToken) ?? "";
  }

  @override
  void setUserAuthToken(String token) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userAuthToken, token);
  }

  @override
  Future<int> getUserId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getInt(_userId) ?? 0;
  }

  @override
  void setUserId(int rollId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setInt(_userId, rollId);
  }






















  @override
  Future<String?> getInstituteId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_instituteId) ?? "";
  }

  @override
  void setInstituteId(String id) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_instituteId, id);
  }

  @override
  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getBool(_loginStatus) ?? false;
  }

  @override
  void setLoginStatus(bool status) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setBool(_loginStatus, status);
  }


  @override
  Future<String> getCandidateId() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_candidateId) ?? "";
  }

  @override
  void setCandidateId(String candidateId) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_candidateId, candidateId);
  }


  @override
  Future<String> getSchoolName() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_schoolName) ?? "";
  }

  @override
  void setSchoolName(String schoolName) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_schoolName, schoolName);
  }




  @override
  Future<String> getUserType() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userType) ?? "";
  }

  @override
  void setUserType(String userType) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userType,userType );
  }

  @override
  void clearOnLogout() async {
    final SharedPreferences prefs = await super.prefs;
    for(String key in prefs.getKeys()) {

      prefs.
      remove(key);
      // }
    }
  }

  @override
  Future<void> setChildrenList(Map<String, String> childrenList) async {
    final SharedPreferences prefs = await super.prefs;
    String encodedChildrenList = jsonEncode(childrenList);
    prefs.setString(_childrenListKey, encodedChildrenList);
  }

  @override
  Future<Map<String, String>> getChildrenList() async {
    final SharedPreferences prefs = await super.prefs;
    String? encodedChildrenList = prefs.getString(_childrenListKey);

    if (encodedChildrenList != null) {
      Map<String, dynamic> decodedMap = jsonDecode(encodedChildrenList);
      return decodedMap.map((key, value) => MapEntry(key, value.toString())); // Ensure values are String
    }

    return {}; // Return empty map if no data exists
  }

  @override
  Future<String> getChildrenCount() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_childrenCount) ?? "";
  }

  @override
  void setChildrenCount(String childrenCount) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_childrenCount,childrenCount);
  }
















///////////////////////////////
  @override
  Future<bool> getPremimumStatus() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getBool(_premimumStatus) ?? false;
  }



  @override
  Future<String> getAddress() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_Address) ?? "";
  }

  @override
  Future<String> getOccupation() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_Occupation) ?? "";
  }




  @override
  Future<String> getPhoneCode() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_phoneCode) ?? "";
  }

  @override
  Future<String> getGender() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userAge) ?? "";
  }

  @override
  Future<String> getName() async {
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_userName) ?? "";
  }

  /////////////////////////////////


  @override
  void setPremimumStatus(bool status) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setBool(_premimumStatus, status);
  }



  @override
  void setAddress(String token) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_Address, token);
  }

  @override
  void setOccupation(String token) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_Occupation, token);
  }



  @override
  void setPhoneCode(String data) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_phoneCode, data);
  }

  @override
  void setGender(String data) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userAge, data);
  }

  @override
  void setName(String data) async {
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_userName, data);
  }



  @override
  Future<String> getEmail() async{
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_emailId) ?? "";
  }

  @override
  Future<String> getPhone() async{
    final SharedPreferences prefs = await super.prefs;
    return prefs.getString(_phoneNumber) ?? "";
  }

  @override
  void setEmail(String data) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_emailId, data);
  }

  @override
  void setPhone(String data) async{
    final SharedPreferences prefs = await super.prefs;
    prefs.setString(_phoneNumber, data);
  }








}