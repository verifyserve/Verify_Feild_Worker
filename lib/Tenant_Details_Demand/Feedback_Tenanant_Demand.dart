import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home_Screen_click/Add_RealEstate.dart';
import '../constant.dart';
import 'Add_TenantDemands.dart';
import 'Assigned_demand_Add_MainTenant_Demand.dart';
import 'Perant_Class_Accpte_Demand.dart';
import 'Tenant_demands_details.dart';

class Catid {
  final int id;
  final String fieldworkar_name;
  final String fieldworkar_number;
  final String demand_name;
  final String demand_number;
  final String buy_rent;
  final String place;
  final String feedback;

  Catid(
      {required this.id, required this.fieldworkar_name, required this.fieldworkar_number, required this.demand_name, required this.demand_number,
        required this.buy_rent, required this.place, required this.feedback});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['id'],
        fieldworkar_name: json['fieldworkar_name'],
        fieldworkar_number: json['fieldworkar_number'],
        demand_name: json['demand_name'],
        demand_number: json['demand_number'],
        buy_rent: json['buy_rent'],
        place: json['add_info'],
        feedback: json['feedback']);
  }
}

class Feedback_demand extends StatefulWidget {
  const Feedback_demand({super.key});

  @override
  State<Feedback_demand> createState() => _Feedback_demandState();
}

class _Feedback_demandState extends State<Feedback_demand> {

  String _num = '';


  Future<List<Catid>> fetchData(id) async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/display_assign_tenant_demand_by_feild_num_looking_location_?fieldworkar_number=$_num&looking_type=Pending&location_=SultanPur');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['id'].compareTo(a['id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    _loaduserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: FutureBuilder<List<Catid>>(
            future: fetchData(""+1.toString()),
            builder: (context,abc){
              if(abc.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else if(abc.hasError){
                return Text('${abc.error}');
              }
              else if (abc.data == null || abc.data!.isEmpty) {
                // If the list is empty, show an empty image
                return Center(
                  child: Column(
                    children: [
                      // Lottie.asset("assets/images/no data.json",width: 450),
                      Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                    ],
                  ),
                );
              }
              else{
                return ListView.builder(
                    itemCount: abc.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context,int len){
                      return GestureDetector(
                        onTap: () async {
                          //  int itemId = abc.data![len].id;
                          //int iiid = abc.data![len].PropertyAddress
                          /*SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('id_Document', abc.data![len].id.toString());*/
                          /*SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('id_Building', abc.data![len].id);
                          prefs.setString('id_Longitude', abc.data![len].Longitude.toString());
                          prefs.setString('id_Latitude', abc.data![len].Latitude.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute
                                (builder: (context) => Tenant_Demands_details())
                          );*/

                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [

                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.greenAccent),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.greenAccent.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //SizedBox(width: 10,),
                                              Text(""+abc.data![len].buy_rent/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                        SizedBox(
                                          width: 10,
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.greenAccent),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.greenAccent.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //SizedBox(width: 10,),
                                              Text(""+abc.data![len].place/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text(" Name | Number",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.red),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.red.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //w SizedBox(width: 10,),
                                              Text(""+abc.data![len].demand_name/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),

                                        GestureDetector(
                                          onTap: (){

                                            showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("Call "+abc.data![len].demand_name),
                                                content: Text('Do you really want to Call? '+abc.data![len].demand_name ),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: Text('No'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      FlutterPhoneDirectCaller.callNumber('${abc.data![len].demand_number}');
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            ) ?? false;
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: 1, color: Colors.red),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.red.withOpacity(0.5),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Iconsax.call,size: 15,color: Colors.red,),
                                                SizedBox(width: 4,),
                                                Text(""+abc.data![len].demand_number/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      letterSpacing: 0.5
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text(" Worker Feedback",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.red),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.red.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //w SizedBox(width: 10,),
                                              Text(""+abc.data![len].feedback/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),

                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }


            }

        ),
      ),

    );
  }


  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _num = prefs.getString('number') ?? '';
    });
  }

}
