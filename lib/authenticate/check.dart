import 'package:pizzard/shared/helper_functions.dart';

Future<bool> check() async {
  bool userIsLoggedIn;
  var payload;
  await HelperFunctions.getJwtSharedPreference().then((value) => {
        if (value != null)
          {
            payload = parseJwt(value),
            if (validateJwt(payload)) {userIsLoggedIn = true}
          }
      });
  return userIsLoggedIn;
}
