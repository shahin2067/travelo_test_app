import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelo_test_app/model/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  bool _registrationSuccessful = false;
  bool get registrationSuccessful => _registrationSuccessful;

  bool _loginSuccessful = false;
  bool get loginSuccessful => _loginSuccessful;

  bool _otpVerifySuccessful = false;
  bool get otpVerifySuccessful => _otpVerifySuccessful;

  bool _isLoadingData = false;
  bool get isLoadingData => _isLoadingData;
  void setLoading(bool isLoading) {
    _isLoadingData = isLoading;
    notifyListeners();
  }

  int? _registrationOtp;
  int? get registrationOtp => _registrationOtp;

  Future<void> registerUser(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    try {
      _isLoadingData = true;
      if (connectivityResult == ConnectivityResult.none) {
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.showToast('No Internet Connection',
              duration: const Duration(seconds: 2));
        });
      } else {
        String url = 'https://travelo-api.products8.xyz/api/register';
        var response = await http.post(Uri.parse(url), body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        });

        if (response.statusCode == 200) {
          // Successful registration
          _registrationSuccessful = true;
          _isLoadingData = false;

          Map<String, dynamic> responseData = json.decode(response.body);
          _registrationOtp = responseData['otp'];
          notifyListeners();
        } else {
          // Handle error
          _registrationSuccessful = false;
          _isLoadingData = false;

          notifyListeners();
          String responseBody = response.body;
          Map<String, dynamic> decodedResponse = json.decode(responseBody);
          Map<String, dynamic> errors = decodedResponse['errors'];
          List<dynamic> emailErrors = errors['email'];

          String errorMessage = emailErrors.isNotEmpty ? emailErrors.first : '';

          Future.delayed(const Duration(milliseconds: 500), () {
            EasyLoading.showError(errorMessage,
                duration: const Duration(seconds: 2));
          });
        }
      }
    } catch (error) {
      // Handle other exceptions
      _registrationSuccessful = false;
      notifyListeners();
      print('Exception occurred: $error');
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    try {
      _isLoadingData = true;
      if (connectivityResult == ConnectivityResult.none) {
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.showToast('No Internet Connection',
              duration: const Duration(seconds: 2));
        });
      } else {
        String url = 'https://travelo-api.products8.xyz/api/login';
        var response = await http.post(Uri.parse(url), body: {
          'email': email,
          'password': password,
        });

        if (response.statusCode == 200) {
          // Successful registration
          _loginSuccessful = true;
          _isLoadingData = false;
          notifyListeners();
          Map<String, dynamic> responseData = json.decode(response.body);
          _user = UserModel.fromJson(responseData);
        } else {
          // Handle error
          _loginSuccessful = false;
          _isLoadingData = false;

          notifyListeners();
          // Save login info to shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setString('userEmail', email);
          prefs.setString('userPassword', password);

          String responseBody = response.body;
          Map<String, dynamic> decodedResponse = json.decode(responseBody);
          List<dynamic> messages = decodedResponse['message'];

          String errorMessage = messages.isNotEmpty ? messages.first : '';
          Future.delayed(const Duration(milliseconds: 500), () {
            EasyLoading.showError(errorMessage,
                duration: const Duration(seconds: 2));
          });

          print(errorMessage);
        }
      }
    } catch (error) {
      // Handle other exceptions
      _loginSuccessful = false;
      notifyListeners();
      print('Exception occurred: $error');
    }
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('userEmail');
    prefs.remove('userPassword');
    _loginSuccessful = false;
    _user = null;
    notifyListeners();
  }

  Future<void> otpVerification(
      {required String name,
      required String email,
      required String password,
      required String tempOtp,
      String? otpCode}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    try {
      _isLoadingData = true;

      if (connectivityResult == ConnectivityResult.none) {
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.showToast('No Internet Connection',
              duration: const Duration(seconds: 2));
        });
      } else {
        String url = 'https://travelo-api.products8.xyz/api/verify_otp';
        var response = await http.post(Uri.parse(url), body: {
          'name': name,
          'email': email,
          'password': password,
          'temp_otp': tempOtp,
          'otp_code': otpCode,
        });

        if (response.statusCode == 201) {
          // Successful registration
          _otpVerifySuccessful = true;
          _isLoadingData = false;
          notifyListeners();
        } else {
          // Handle error
          _otpVerifySuccessful = false;
          _isLoadingData = false;

          notifyListeners();

          Future.delayed(const Duration(milliseconds: 500), () {
            EasyLoading.showError(response.body,
                duration: const Duration(seconds: 2));
          });

          print(response.body);
        }
      }
    } catch (error) {
      // Handle other exceptions
      _otpVerifySuccessful = false;
      notifyListeners();
      print('Exception occurred: $error');
    }
  }
}
