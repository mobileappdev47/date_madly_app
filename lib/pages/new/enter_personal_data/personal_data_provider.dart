import 'package:date_madly_app/api/get_single_profile_api.dart';
import 'package:date_madly_app/api/updateuserfeilds_api.dart';
import 'package:date_madly_app/models/get_single_profile_model.dart';
import 'package:date_madly_app/models/update_user.dart';
import 'package:date_madly_app/service/pref_service.dart';
import 'package:date_madly_app/utils/pref_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Updateprovider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  String name = '';
  String dob = '';
  String location = '';
  String job = '';
  String company = '';
  String college = '';
  String gender = 'Male';

  String nameError = '';
  String dobError = '';
  String locationError = '';
  String jobError = '';
  String companyError = '';
  String collegeError = '';
  String genderError = '';

  GetSingleProfileModel getSingleProfileModel = GetSingleProfileModel();
  bool loader = false;
  getSingleProfileApi(context) async {
    try {
      loader = true;
      notifyListeners();
      getSingleProfileModel = await GetSingleProfileApi.getSingleProfileApi(
          context, PrefService.getString(PrefKeys.userId));

      loader = false;
      notifyListeners();
    } catch (e) {
      loader = false;
      notifyListeners();
    }
  }

  // UpdateUsers updateUsers = UpdateUsers();

  // updateApiCall(BuildContext context,body) async {
  //   try {
  //     loader = true;
  //     setState(() {});
  //     updateUsers = await UpdateUserApi.updateUsers(body, context, imageFile);
  //     loader = false;
  //     setState(() {});
  //   } catch (e) {
  //     loader = false;
  //     setState(() {});
  //     print(e.toString());
  //   }
  // }

  jobValidation() {
    if (jobController.text.trim() == "") {
      jobError = 'Enter the Job';
      notifyListeners();
      return false;
    } else {
      jobError = '';
      notifyListeners();
      return true;
    }
  }

  locationValidation() {
    if (locationController.text.trim() == "") {
      locationError = 'Enter the location';
      notifyListeners();
      return false;
    } else {
      locationError = '';
      notifyListeners();
      return true;
    }
  }

  nameValidation() {
    if (nameController.text.trim() == "") {
      nameError = 'Enter the Name';
      notifyListeners();
      return false;
    } else {
      nameError = '';
      notifyListeners();
      return true;
    }
  }

  dobValidation() {
    if (dobController.text.trim() == "") {
      dobError = 'Enter the Date of Birth';
      notifyListeners();
      return false;
    } else {
      dobError = '';
      notifyListeners();
      return true;
    }
  }

  companyValidation() {
    if (companyController.text.trim() == "") {
      companyError = 'Enter the Company';
      notifyListeners();
      return false;
    } else {
      companyError = '';
      notifyListeners();
      return true;
    }
  }

  collegeValidation() {
    if (companyController.text.trim() == "") {
      collegeError = 'Enter the College';
      notifyListeners();
      return false;
    } else {
      collegeError = '';
      notifyListeners();
      return true;
    }
  }

  genderValidation() {
    if (gender.isEmpty) {
      genderError = 'Select Gender';
      notifyListeners();
      return false;
    } else {
      genderError = '';
      notifyListeners();
      return true;
    }
  }

  val() async {
    nameValidation();
    dobValidation();
    jobValidation();
    locationValidation();
    companyValidation();
    collegeValidation();
    genderValidation();
  }

  validation() {
    val();
    if (nameError == '' &&
        dobError == '' &&
        jobError == '' &&
        locationError == '' &&
        companyError == '' &&
        collegeError == '' &&
        genderError == '') {
      return true;
    } else {
      return false;
    }
  }

  String data = "";

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      dobController.text = DateFormat('dd MMM, yyyy').format(picked);
      // setState(() {
      data = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners();
      // });

      // Handle the selected date, e.g., update a variable or display it
      print('Selected date: ${dobController.text}');
    }
  }
}
