import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import 'Show_tenant.dart';

class TenantDetails extends StatefulWidget {
  const TenantDetails({super.key});

  @override
  State<TenantDetails> createState() => _TenantDetailsState();
}

class _TenantDetailsState extends State<TenantDetails> {



  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences preferences;
  ValueNotifier<String>name=ValueNotifier("");
  ValueNotifier<String>email=ValueNotifier("");
  ValueNotifier<String>number=ValueNotifier("");

  @override
  void initState() {
    super.initState();
    init();
    _Tenant_Rented_Date.text = "";
    _loaduserdata();
  }

  init()async{
    preferences=await SharedPreferences.getInstance();
    name.value=preferences.getString("name")??'';
    email.value=preferences.getString("email")??'';
    number.value=preferences.getString("phone")??'';

  }
  String data1 = '';

  String _Property_Number = '';
  String _PropertyAddress = '';
  String _Looking_Prop_ = '';
  String _FLoorr = '';
  String _Flat = '';

  String _Owner_Name = '';
  String _Owner_Number = '';
  String _fieldworkarname = '';
  String _fieldworkarnumber = '';

  String _property_image = '';
  String _maintence = '';
  String _bhk_bhk = '';

  //TextEditingController dateinput = TextEditingController();

  final TextEditingController _Tenant_Name = TextEditingController();
  final TextEditingController _Tenant_Rented_Amount = TextEditingController();
  final TextEditingController _Tenant_Rented_Date = TextEditingController();
  final TextEditingController _About_tenant = TextEditingController();
  final TextEditingController _Tenant_Number = TextEditingController();
  final TextEditingController _Tenant_Email = TextEditingController();
  final TextEditingController _Tenant_WorkProfile = TextEditingController();
  final TextEditingController _Tenant_Members = TextEditingController();

  Future<void> fetchdata(Tenant_Name,Tenant_Rented_Amount,Tenant_Rented_Date,Tenant_Number,Tenant_Email,Tenant_WorkProfile,Tenant_Members) async{
    final responce = await http.get(Uri.parse
      ('https://verifyserve.social/WebService4.asmx/insert_Verify_AddTenant_Under_Property_Table?Property_Image=$_property_image&Property_Number=$_Property_Number&PropertyAddress=$_PropertyAddress&Looking_Prop_=$_Looking_Prop_&maintence=$_maintence&FLoorr=$_FLoorr&Flat=$_Flat&Tenant_Name=$Tenant_Name&Tenant_Rented_Amount=$Tenant_Rented_Amount&Tenant_Rented_Date=$Tenant_Rented_Date&bhk=$_bhk_bhk&Tenant_Number=$Tenant_Number&Tenant_Email=$Tenant_Email&Tenant_WorkProfile=$Tenant_WorkProfile&Tenant_Members=$Tenant_Members&Owner_Name=$_Owner_Name&Owner_Number=$_Owner_Number&Subid=$data1&fieldworkarname=$_fieldworkarname&fieldworkarnumber=$_fieldworkarnumber'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      fetchdata_update();

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  Future<void> fetchdata_update() async{
    final responce = await http.get(Uri.parse
      ('https://verifyserve.social/WebService4.asmx/Update_Book_Realestate_by_feildworker?idd=$data1&looking=Tenant_Added'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  String? dropdownValue,dropdownValue_dob,dropdownValue_gender;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Image.asset(AppImages.verify, height: 75),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Row(
            children: [
              SizedBox(
                width: 3,
              ),
              Icon(
                PhosphorIcons.caret_left_bold,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Name',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(style: TextStyle(color: Colors.black),
                  controller: _Tenant_Name,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Name",
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Number',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(style: TextStyle(color: Colors.black),
                  controller: _Tenant_Number,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Number",
                      prefixIcon: Icon(
                        PhosphorIcons.phone_call,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Tenant Email',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(style: TextStyle(color: Colors.black),
                  controller: _Tenant_Email,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Email",
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Rent Amount',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  controller: _Tenant_Rented_Amount,
                  decoration: InputDecoration(
                      hintText: "Enter Rent Amount",
                      prefixIcon: Icon(
                        PhosphorIcons.currency_inr,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('Rent Date',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: K.boxShadow,
                      ),
                      child: TextField(style: TextStyle(color: Colors.black),
                        controller: _Tenant_Rented_Date,
                        readOnly: true,
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2010), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            //yyyy-MM-dd
                            setState(() {
                              _Tenant_Rented_Date.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Rent Date",
                            prefixIcon: Icon(
                              PhosphorIcons.calendar,
                              color: Colors.black54,
                            ),
                            hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.pinkAccent.shade100
                    ),
                    child: IconButton(
                      onPressed: () async{
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2010), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement
                          //yyyy-MM-dd
                          setState(() {
                            _Tenant_Rented_Date.text = formattedDate; //set output date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },
                      icon: Icon(
                        PhosphorIcons.calendar,
                        color: Colors.black,
                      ),),
                  )
                ],
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Tenant WorkProfile",style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(style: TextStyle(color: Colors.black),
                  controller: _Tenant_WorkProfile,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant WorkProfile",
                      prefixIcon: Icon(
                        Icons.work_outline,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Tenant Members",style: TextStyle(fontSize: 16,color: Colors.grey[500],fontFamily: 'Poppins'),)),

              SizedBox(height: 5,),

              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextField(style: TextStyle(color: Colors.black),
                  controller: _Tenant_Members,
                  decoration: InputDecoration(
                      hintText: "Enter Tenant Members",
                      prefixIcon: Icon(
                        Icons.people_alt_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins',),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 40,),

              Center(
                child:  ValueListenableBuilder(
                    valueListenable: name,
                    builder: (context, String n,__) {
                      return ValueListenableBuilder(
                          valueListenable: email,
                          builder: (context, String e,__) {
                            return ValueListenableBuilder(
                                valueListenable: number,
                                builder: (context, String num,__) {
                                  return Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: Colors.red.withOpacity(0.8)
                                    ),



                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red
                                      ),
                                      onPressed: (){

                                        //data = _email.toString();
                                        fetchdata(_Tenant_Name.text ,_Tenant_Rented_Amount.text, _Tenant_Rented_Date.text,_Tenant_Number.text, _Tenant_Email.text, _Tenant_WorkProfile.text, _Tenant_Members.text);

                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ShowProperty(),), (route) => route.isFirst);

                                      }, child: Text("Submit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, ),
                                    ),
                                    ),

                                  );
                                }
                            );
                          }
                      );
                    }
                ),
              ),

              SizedBox(height: 40,),

            ],
          ),
        ),
      ),
    );
  }
  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data1 = prefs.getString('id_Subid') ?? '';

      _Property_Number = prefs.getString('Property_Number') ?? '';
      _PropertyAddress = prefs.getString('PropertyAddress') ?? '';
      _Looking_Prop_ = prefs.getString('Looking_Prop_') ?? '';
      _FLoorr = prefs.getString('FLoorr') ?? '';
      _Flat = prefs.getString('Flat') ?? '';

      _Owner_Name = prefs.getString('Owner_Name') ?? '';
      _Owner_Number = prefs.getString('Owner_Number') ?? '';
      _fieldworkarname = prefs.getString('fieldworkarname') ?? '';
      _fieldworkarnumber = prefs.getString('fieldworkarnumber') ?? '';

      _property_image = prefs.getString('property_image') ?? '';
      _maintence = prefs.getString('maintence') ?? '';
      _bhk_bhk = prefs.getString('bhk_bhk') ?? '';
    });


  }
}
