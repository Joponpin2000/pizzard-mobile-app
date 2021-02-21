import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzard/main.dart';
import 'package:pizzard/shared/helper_functions.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  String email;
  bool _loading = true;

  @override
  void initState() {
    initializeStateValues();
    super.initState();
  }

  initializeStateValues() async {
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      } else {
        showToast("Login to view profile");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    });
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      } else {
        showToast("Login to view profile");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    });
    if (name != null && email!= null) {
    setState(() {
      _loading = false;
    });
    }
  }

  void showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.transparent,
      textColor: Colors.red,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      child: ListTile(
                        leading: Text("Account Details", style: TextStyle(fontSize: 18),),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle_rounded,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
                        ),
                        title: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      height: 0.1,
                    ),
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.mail_outline_rounded,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          email,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      height: 0.1,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
