import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify_feild_worker/Administrator/Administrator_HomeScreen.dart';
import 'package:verify_feild_worker/Home_Screen.dart';
import 'package:verify_feild_worker/Login_page.dart';
import 'package:http/http.dart' as http;

class Catid {
  final String F_Name;
  final String F_Number;
  final String FAadharCard;

  Catid(
      {required this.F_Name, required this.F_Number, required this.FAadharCard});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(
        F_Name: json['FName'],
        F_Number: json['FNumber'],
        FAadharCard: json['FAadharCard']);
  }
}

class Splash extends StatefulWidget {
  static const route = "/";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Future<List<Catid>> fetchData_account(llogin) async {
    var url = Uri.parse("https://verifyserve.social/WebService3_ServiceWork.asmx/account_FeildWorkers_Register?num=${llogin}");
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
  void initState() {
    super.initState();
    init();
  }

  init()async{

   // Navigator.of(context).pushReplacementNamed(HomeBar.route);

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? lloginn = pref.getString("number");
    fetchData_account(lloginn);

    if(lloginn != null){
      final result_Tenant = await fetchData_account(lloginn);
      print(result_Tenant.first.FAadharCard);
      if(lloginn.isNotEmpty){
        if(result_Tenant.first.FAadharCard == "Administrator"){

          Navigator.of(context).pushReplacementNamed(AdministratorHome_Screen.route);
          return Center(child: CircularProgressIndicator());
        }
        else if (result_Tenant.first.FAadharCard == "FieldWorkar"){

          Navigator.of(context).pushReplacementNamed(Home_Screen.route);
          return Center(child: CircularProgressIndicator());
        }

      }else{
        Navigator.of(context).pushReplacementNamed(Login_page.route);
      }
    }else{
      Navigator.of(context).pushReplacementNamed(Login_page.route);
    }
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/VerifyLogo.png", width: 200, height: 200,),
          ],
        ),
      ),
    );
  }
}
