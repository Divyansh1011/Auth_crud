import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future singUp(
      {@required String email,
      @required String password,
      @required String fullname}) async {
    setBusy(true);

    var authresult = await _authenticationService.signUpEmail(
        email: email,
        password: password,
        fullname: fullname,
        roles: _selectedRole);

    setBusy(false);

    if (authresult is bool) {
      if (authresult) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
            title: "Sign in faliure",
            description: "General sign in failure.Pls try again later");
      }
    } else {
      await _dialogService.showDialog(
          title: "Sign in faliure", description: authresult);
    }
  }

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }
}
