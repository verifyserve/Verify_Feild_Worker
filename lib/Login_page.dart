import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Administrator/Administrator_HomeScreen.dart';
import 'Demo.dart';
import 'Home_Screen.dart';
import 'constant.dart';

class Catid {
  final String F_Name;
  final String F_Number;
  final String FAadharCard;
  final String FLocation;

  Catid(
      {required this.F_Name, required this.F_Number, required this.FAadharCard, required this.FLocation});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(
        F_Name: json['FName'],
        F_Number: json['FNumber'],
        FAadharCard: json['FAadharCard'],
        FLocation: json['F_Location']);
  }
}

class Login_page extends StatefulWidget {
  static const route = "/Login_page";
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> fetchdata(num,pass) async{
    final responce = await http.get(Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/Feild_LoginApi?number=$num&password=$pass"));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    print(responce.body);

    if (responce.body == '[{"logg":1}]'){
      /*Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(name: "/Page1"),
          builder: (context) => Home_Screen(),
        ),
      );*/

      final result = await fetchData_account();

      if(result.first.FAadharCard == "Administrator"){
        Navigator.of(context).pushNamedAndRemoveUntil(AdministratorHome_Screen.route, (route) => false);
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AdministratorHome_Screen(),), (route) => route.isFirst);
        //Navigator.of(context).pushReplacementNamed(AdministratorHome_Screen.route);
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(settings: RouteSettings(name: "/Page1"),
              builder: (context) => AdministratorHome_Screen(),
            ), (route) => route.isFirst);*/
        /*return Center(child: CircularProgressIndicator());*/
      }
      else if (result.first.FAadharCard == "FieldWorkar"){
        Navigator.of(context).pushNamedAndRemoveUntil(Home_Screen.route, (route) => false);
        //Navigator.of(context).pushReplacementNamed(Home_Screen.route);
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home_Screen(),), (route) => route.isFirst);
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(settings: RouteSettings(name: "/Page1"),
              builder: (context) => Home_Screen(),
            ), (route) => route.isFirst);*/

        /*return Center(child: CircularProgressIndicator());*/
      }

      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Successful login
      print("Login successful");
    } else {
      // Failed login
      print("Login Failed");

      Fluttertoast.showToast(
          msg: "Login Failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    /*if (responce.statusCode == 200) {
      // Successful login
      print("Login successful");
      // Do something after successful login, e.g., navigate to another screen
    } else {
      // Failed login
      print("Login failed - ${responce.statusCode}");
      // Handle the failed login, show an error message, etc.
    }*/

  }

  Future<List<Catid>> fetchData_account() async {
    var url = Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/account_FeildWorkers_Register?num=${_mobileController.text}");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Image.asset(
                AppImages.verify,
                height: 170,
                width: 250,
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Sign In!',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  letterSpacing: 0.3),
            ),
            const SizedBox(
              height: 10,
            ),
            //Hey, Enter your details to get sign in to your account
            Text(
              'Hey, Login or Signup to get enter in Verify App',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),


            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:  Colors.white)),
                          color: Colors.white12
                        ),
                        child: TextField(style: TextStyle(color: Colors.white),
                          controller: _mobileController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone number",
                              hintStyle: TextStyle(color: Colors.grey[700])
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: Colors.white12,
                        child: TextField(style: TextStyle(color: Colors.white),
                          obscureText: false,
                          controller: _passController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[700])
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () async {

                      fetchdata(_mobileController.text, _passController.text);
                      final result = await fetchData_account();

                      /*if(result.first.FAadharCard == "Administrator"){
                        //Navigator.of(context).pushReplacementNamed(AdministratorHome_Screen.route);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(settings: RouteSettings(name: "/Page1"),
                              builder: (context) => AdministratorHome_Screen(),
                            ), (route) => route.isFirst);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: RouteSettings(name: "/Page1"),
                            builder: (context) => AdministratorHome_Screen(),
                          ),
                        );
                        return Center(child: CircularProgressIndicator());
                      }
                      else if (result.first.FAadharCard == "FeildWorker"){
                        //Navigator.of(context).pushReplacementNamed(Home_Screen.route);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(settings: RouteSettings(name: "/Page1"),
                              builder: (context) => Home_Screen(),
                            ), (route) => route.isFirst);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: RouteSettings(name: "/Page1"),
                            builder: (context) => Home_Screen(),
                          ),
                        );
                        return Center(child: CircularProgressIndicator());
                      }*/

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (result != null) {
                        prefs.setString('name', result.first.F_Name);
                        prefs.setString('number', result.first.F_Number);
                        prefs.setString('location', result.first.FLocation);



                      } else {
                        // Show error message
                        print("No Data");
                        Fluttertoast.showToast(
                            msg: "No Data ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                     /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home_Screen()));*/
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dropdown()));*/

                      /*fetchdata(NumberController.text, PasswordController.text);
                      final result = await fetchData_account();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (result != null) {
                        prefs.setString('name', result.first.F_Name);
                        prefs.setString('number', result.first.F_Number);

                      } else {
                        // Show error message
                        print("No Data");
                        Fluttertoast.showToast(
                            msg: "No Data ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }*/
                      //Navigator.pop(context);
                      /*Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => const Show_Building()));*/
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child: Center(
                        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),

                ],

              ),
            )


          ],
        ),
      ),

    );
  }
}
