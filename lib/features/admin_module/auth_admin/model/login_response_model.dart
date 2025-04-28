class LoginResponseModel {
  User? user;
  String? accessToken;
  String? tokenType;

  LoginResponseModel({this.user, this.accessToken, this.tokenType});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  int? id;
  String? empId;
  int? roleId;
  String? salutation;
  String? name;
  String? email;
  String? phoneNo;
  String? fatherName;
  String? motherName;
  String? gender;
  String? maritalStatus;
  String? bloodGroup;
  String? dob;
  String? joiningDate;
  String? whatsappNo;
  String? emgNo;
  String? profileImg;
  String? currentAddress;
  String? permanentAddress;
  String? qualification;
  String? experience;
  String? specialization;
  String? note;
  String? panNumber;
  String? identificationName;
  String? identificationNumber;
  String? signature;
  int? departmentId;
  int? categoryId;
  int? subCategoryId;
  String? doctorType;
  String? doctorFees;
  int? chargeId;
  String? commissionType;
  String? commissionAmount;
  String? salaryMasterId;
  String? basicSalary;
  String? userType;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.empId,
        this.roleId,
        this.salutation,
        this.name,
        this.email,
        this.phoneNo,
        this.fatherName,
        this.motherName,
        this.gender,
        this.maritalStatus,
        this.bloodGroup,
        this.dob,
        this.joiningDate,
        this.whatsappNo,
        this.emgNo,
        this.profileImg,
        this.currentAddress,
        this.permanentAddress,
        this.qualification,
        this.experience,
        this.specialization,
        this.note,
        this.panNumber,
        this.identificationName,
        this.identificationNumber,
        this.signature,
        this.departmentId,
        this.categoryId,
        this.subCategoryId,
        this.doctorType,
        this.doctorFees,
        this.chargeId,
        this.commissionType,
        this.commissionAmount,
        this.salaryMasterId,
        this.basicSalary,
        this.userType,
        this.isActive,
        this.isDelete,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empId = json['empId'];
    roleId = json['role_id'];
    salutation = json['salutation'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    bloodGroup = json['blood_group'];
    dob = json['dob'];
    joiningDate = json['joining_date'];
    whatsappNo = json['whatsapp_no'];
    emgNo = json['emg_no'];
    profileImg = json['profile_img'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    qualification = json['qualification'];
    experience = json['experience'];
    specialization = json['specialization'];
    note = json['note'];
    panNumber = json['pan_number'];
    identificationName = json['identification_name'];
    identificationNumber = json['identification_number'];
    signature = json['signature'];
    departmentId = json['department_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    doctorType = json['doctor_type'];
    doctorFees = json['doctor_fees'];
    chargeId = json['charge_id'];
    commissionType = json['commission_type'];
    commissionAmount = json['commission_amount'];
    salaryMasterId = json['salary_master_id'];
    basicSalary = json['basic_salary'];
    userType = json['user_type'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['empId'] = this.empId;
    data['role_id'] = this.roleId;
    data['salutation'] = this.salutation;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['blood_group'] = this.bloodGroup;
    data['dob'] = this.dob;
    data['joining_date'] = this.joiningDate;
    data['whatsapp_no'] = this.whatsappNo;
    data['emg_no'] = this.emgNo;
    data['profile_img'] = this.profileImg;
    data['current_address'] = this.currentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['qualification'] = this.qualification;
    data['experience'] = this.experience;
    data['specialization'] = this.specialization;
    data['note'] = this.note;
    data['pan_number'] = this.panNumber;
    data['identification_name'] = this.identificationName;
    data['identification_number'] = this.identificationNumber;
    data['signature'] = this.signature;
    data['department_id'] = this.departmentId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['doctor_type'] = this.doctorType;
    data['doctor_fees'] = this.doctorFees;
    data['charge_id'] = this.chargeId;
    data['commission_type'] = this.commissionType;
    data['commission_amount'] = this.commissionAmount;
    data['salary_master_id'] = this.salaryMasterId;
    data['basic_salary'] = this.basicSalary;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}