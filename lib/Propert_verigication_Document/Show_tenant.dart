import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home_Screen_click/View_All_Details.dart';
import '../Police_Verification/Owner_Details.dart';
import '../Police_Verification/Property_Verify_Details.dart';
import '../constant.dart';
import '../model/doctenantSlider.dart';
import 'Add_Tenant.dart';
import 'Property_Verification.dart';
import 'ViewAll_Details.dart';


class Catid {
  final int tup_id;
  final String Reelestate_Image;
  final String Address_;
  final String Place_;
  final String floor_ ;
  final String flat_;
  final String Tenant_Rented_Amount;
  final String Tenant_Rented_Date;
  final String Owner_number;
  final String Tenant_number;
  final String maintence;
  final String Bhk_Squarefit;
  final String Subid;

  Catid(
      {required this.tup_id,required this.Reelestate_Image,required this.Address_,required this.Place_,required this.floor_,required this.flat_,
        required this.Tenant_Rented_Amount,required this.Tenant_Rented_Date,required this.Owner_number,required this.Tenant_number,required this.maintence,required this.Bhk_Squarefit,required this.Subid});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(tup_id: json['TUP_id'],Address_: json['Property_Number'],
        Reelestate_Image: json['Property_Image'],Place_: json['PropertyAddress'],
        floor_: json['FLoorr'], flat_: json['Flat'],
        Tenant_Rented_Amount: json['Tenant_Rented_Amount'], Tenant_Rented_Date: json['Tenant_Rented_Date'],
        Owner_number: json['Owner_Number'], Tenant_number: json['Tenant_Number'],maintence: json['Looking_Prop_'],
        Bhk_Squarefit: json['About_tenant'], Subid: json['Subid']);
  }
}


class Catid_real {
  final int id;
  final String Flat;
  final String Building_Address;
  final String Building_Location;
  final String Building_image;
  final String Longitude;
  final String Latitude;
  final String Rent;
  final String Verify_price;
  final String BHK;
  final String sqft;
  final String tyope;
  final String floor_ ;
  final String maintence ;
  final String buy_Rent ;
  final String Building_information;
  final String Parking;
  final String balcony;
  final String facility;
  final String Furnished;
  final String kitchen;
  final String Baathroom;
  final String Ownername;
  final String Owner_number;
  final String fieldworkarname;
  final String fieldworkarnumber;

  Catid_real(
      {required this.id, required this.Flat, required this.Building_Address, required this.Building_Location, required this.Building_image, required this.Longitude, required this.Latitude, required this.Rent, required this.Verify_price, required this.BHK, required this.sqft, required this.tyope, required this.floor_, required this.maintence, required this.buy_Rent,
        required this.Building_information,required this.balcony,required this.Parking,required this.facility,required this.Furnished,required this.kitchen,required this.Baathroom,required this.Ownername,required this.Owner_number,required this.fieldworkarname,required this.fieldworkarnumber});

  factory Catid_real.FromJson(Map<String, dynamic>json){
    return Catid_real(id: json['PVR_id'],
        Flat: json['flat_'],
        Building_Address: json['Address_'],
        Building_Location: json['Place_'],
        Building_image: json['Realstate_image'],
        Longitude: json['Longtitude'],
        Latitude: json['Latitude'],
        Rent: json['Property_Number'],
        Verify_price: json['Gas_meter'],
        BHK: json['Bhk_Squarefit'],
        sqft: json['City'],
        tyope: json['Typeofproperty'],
        floor_: json['floor_'],
        maintence: json['maintenance'],
        buy_Rent: json['Buy_Rent'],
        Building_information: json['Building_information'],
        balcony: json['balcony'],
        Parking: json['Parking'],
        facility: json['Lift'],
        Furnished: json['Furnished'],
        kitchen: json['kitchen'],
        Baathroom: json['Baathroom'],
        Ownername: json['Ownername'],
        Owner_number: json['Owner_number'],
        fieldworkarname: json['fieldworkarname'],
        fieldworkarnumber: json['fieldworkarnumber']);
  }
}

class Servant {
  //final int id;
  final String Servant_Name;
  final String Servant_Number;
  final String Work_Timing;
  final String Servant_Work;

  Servant(
      {required this.Servant_Name, required this.Servant_Number, required this.Work_Timing, required this.Servant_Work});

  factory Servant.FromJson(Map<String, dynamic>json){
    return Servant(Servant_Name: json['Servant_Name'],
        Servant_Number: json['Servant_Number'],
        Work_Timing: json['Work_Timing'],
        Servant_Work: json['Servant_Work']);
  }
}

class ShowProperty extends StatefulWidget {
  const ShowProperty({Key? key}) : super(key: key);

  State<ShowProperty> createState() => _ShowPropertyState();
}

class _ShowPropertyState extends State<ShowProperty> {
  // late DocumentationBloc bloc;
  List<String> tittle = ["All Properties","Add Tenants"];
  int? pageIndex=0;
  List<String> gridImages = [
    AppImages.documents,
    AppImages.notification,
    AppImages.realEstate,
    AppImages.vehicle,
    AppImages.insurance,
    AppImages.services,
    AppImages.jobs,
    AppImages.itAndDesigner,
    AppImages.consultantAndLowers,
    AppImages.hotels,
    AppImages.eventsAndWeeding,
    AppImages.trucksAndJcb,
  ];

  @override
  void initState() {
    //  bloc = context.read<DocumentationBloc>();
    super.initState();
    _loaduserdata();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        // isLoading = false;
      });
    });
  }

  String data1 = '';
  String _Owner_Number = '';
  String _number = '';

  Future<List<Catid>> fetchData() async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/Show_Tenant_Table_by_Feildworker_Number_?fieldworkarnumber=$_number");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['TUP_id'].compareTo(a['TUP_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid_real>> fetchData_All(id) async{

    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_propertyverifycation_by_lookingproperty_fieldworkarnumber?Looking_Property_=Book&fieldworkarnumber=$_number");
    final responce=await http.get(url);
    if(responce.statusCode==200){

      List listresponce=json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));

      return listresponce.map((data) => Catid_real.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }


  }

  Future<List<Catid_real>> fetchDataone() async{
    var url=Uri.parse("https://verifyserve.social/WebService4.asmx/show_propertyverifycation_by_lookingproperty_fieldworkarnumber?Looking_Property_=Book&fieldworkarnumber=$_number");
    final responce=await http.get(url);
    if(responce.statusCode==200){

      List listresponce=json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid_real.FromJson(data)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
  }

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
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            SizedBox(height: 15,),

            SizedBox(

              height: 40,
              child: ListView.builder(
                itemCount: tittle.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      pageIndex = index;
                      if(pageIndex == 1){
                        //bloc.yourInfo(widget.data.dTPid);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.only(left: 10,),
                      decoration: BoxDecoration(
                          color:
                          pageIndex == index ? Colors.teal : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        tittle[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: pageIndex == index
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            if(pageIndex == 0)
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: FutureBuilder<List<Catid>>(
                      future: fetchData(),
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
                                //Lottie.asset("assets/images/no data.json",width: 450),
                                Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                              ],
                            ),
                          );
                        }
                        else{
                          return ListView.builder(
                              itemCount: abc.data!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context,int len){
                                return GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('Building_Sibid_', abc.data![len].Subid);
                                    prefs.setString('Owner_Number_For_PoliceVerification', abc.data![len].Owner_number.toString());
                                    prefs.setString('Tenant_Number_For_PoliceVerification', abc.data![len].Tenant_number.toString());
                                    prefs.setString('FLoorr_For_PoliceVerification', abc.data![len].floor_.toString());
                                    prefs.setString('Flat_PoliceVerification', abc.data![len].flat_.toString());
                                    prefs.setString('Tenant_Rented_Amount_PoliceVerification', abc.data![len].Tenant_Rented_Amount.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => View_Detailsdocs(iidd: '${abc.data![len].tup_id.toString()}', SUbid: '${abc.data![len].Subid.toString()}',)),
                                    );
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Owner_details()),
                                    );*/
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                          const BorderRadius.all(Radius.circular(10)),
                                                          child: Container(
                                                            height: 100,
                                                            width: 120,
                                                            child: CachedNetworkImage(
                                                              imageUrl:
                                                              "https://verifyserve.social/"+abc.data![len].Reelestate_Image,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context, url) => Image.asset(
                                                                AppImages.loading,
                                                                fit: BoxFit.cover,
                                                              ),
                                                              errorWidget: (context, error, stack) =>
                                                                  Image.asset(
                                                                    AppImages.imageNotFound,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          children: [

                                                            SizedBox(
                                                              width: 5,
                                                            ),

                                                            Container(
                                                              padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(width: 1, color: Colors.purple),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors.purple.withOpacity(0.5),
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
                                                                  Text(""+abc.data![len].floor_/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                    style: TextStyle(
                                                                        fontSize: 12,
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
                                                                border: Border.all(width: 1, color: Colors.orange),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors.orange.withOpacity(0.5),
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
                                                                  Text(""+abc.data![len].Bhk_Squarefit/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                    style: TextStyle(
                                                                        fontSize: 12,
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
                                                          height: 5,
                                                        ),

                                                        Row(
                                                          children: [
                                                            Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                            SizedBox(width: 2,),
                                                            Text("Property Address",
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
                                                          width: 150,
                                                          child: Text("    "+abc.data![len].Address_,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                        Row(
                                                          children: [
                                                            Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                            SizedBox(width: 2,),
                                                            Text("Rent And Maintaince",
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 180,
                                                          child: Text("   "+abc.data![len].Tenant_Rented_Amount+"  |   "+abc.data![len].maintence
                                                            ,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w400
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Row(
                                                  children: [

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
                                                          //SizedBox(width: 10,),
                                                          Text(""+abc.data![len].flat_/*+abc.data![len].flat_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                            style: TextStyle(
                                                                fontSize: 12,
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
                                                        border: Border.all(width: 1, color: Colors.blue),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.blue.withOpacity(0.5),
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
                                                          Text(""+abc.data![len].Place_/*+abc.data![len].flat_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                            style: TextStyle(
                                                                fontSize: 12,
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
                                                        border: Border.all(width: 1, color: Colors.green),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.green.withOpacity(0.5),
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
                                                          Text(""+abc.data![len].Tenant_Rented_Date/*+abc.data![len].floor_*//*+abc.data![len].Building_Name.toUpperCase()*/,
                                                            style: TextStyle(
                                                                fontSize: 12,
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

                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );

                              });
                        }
                      }

                  ),
                ),
              ),
            if(pageIndex == 1)const SizedBox(height: 10,),
            if(pageIndex == 1)
              Expanded(
                child: FutureBuilder<List<Catid_real>>(
                    future: fetchData_All(""+1.toString()),
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
                          prefs.setString('id_Subid', abc.data![len].id.toString());
                          prefs.setString('Property_Number', abc.data![len].Building_Address.toString());
                          prefs.setString('PropertyAddress', abc.data![len].Building_Location.toString());
                          prefs.setString('Looking_Prop_', abc.data![len].tyope.toString());
                          prefs.setString('FLoorr', abc.data![len].floor_.toString());
                          prefs.setString('Flat', abc.data![len].Flat.toString());
                          prefs.setString('Owner_Name', abc.data![len].Ownername.toString());
                          prefs.setString('Owner_Number', abc.data![len].Owner_number.toString());
                          prefs.setString('fieldworkarname', abc.data![len].fieldworkarname.toString());
                          prefs.setString('fieldworkarnumber', abc.data![len].fieldworkarnumber.toString());
                          prefs.setString('property_image', abc.data![len].Building_image.toString());
                          prefs.setString('maintence', abc.data![len].maintence.toString());
                          prefs.setString('bhk_bhk', abc.data![len].BHK.toString());
                          //prefs.setString('Owner_no', abc.data![len].Owner_number.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute
                                (builder: (context) => TenantDetails())
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
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      const BorderRadius.all(Radius.circular(10)),
                                                      child: Container(
                                                        height: 90,
                                                        width: 120,
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                          "https://verifyserve.social/"+abc.data![len].Building_image,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) => Image.asset(
                                                            AppImages.loading,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          errorWidget: (context, error, stack) =>
                                                              Image.asset(
                                                                AppImages.imageNotFound,
                                                                fit: BoxFit.cover,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(width: 1, color: Colors.green),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.green.withOpacity(0.5),
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
                                                          Text(""+abc.data![len].tyope.toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 12,
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
                                                SizedBox(width: 5,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("Property Address",
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
                                                      width: 180,
                                                      child: Text(""+abc.data![len].Building_Address,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("Society",
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
                                                      width: 180,
                                                      child: Text(""+abc.data![len].Building_Location,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                        SizedBox(width: 2,),
                                                        Text("Place",
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(""+abc.data![len].balcony
                                                        ,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Iconsax.building_3_copy,size: 14,color: Colors.red,),
                                                        SizedBox(width: 3,),
                                                        Text(""+abc.data![len].BHK.toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey.shade600,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute
                                                          (builder: (context) => Property_Verify_Details(id: '${abc.data![len].id.toString()}',))
                                                    );
                                                    /*Navigator.push(
                                            context,
                                            MaterialPageRoute
                                              (builder: (context) => Add_Assigned_TenantDemands(id: '${abc.data![len].id.toString()}', name: '${abc.data![len].demand_name.toString()}', number: '${abc.data![len].demand_number.toString()}', buyrent: '${abc.data![len].buy_rent.toString()}',))
                                        );*/
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                                    decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(10),
                                                            bottomRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10)),
                                                        color: Colors.red.withOpacity(0.8)),
                                                    child: Center(
                                                      child: Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            letterSpacing: 0.8,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    prefs.setString('id_Subid', abc.data![len].id.toString());
                                                    prefs.setString('Property_Number', abc.data![len].Building_Address.toString());
                                                    prefs.setString('PropertyAddress', abc.data![len].Building_Location.toString());
                                                    prefs.setString('Looking_Prop_', abc.data![len].tyope.toString());
                                                    prefs.setString('FLoorr', abc.data![len].floor_.toString());
                                                    prefs.setString('Flat', abc.data![len].Flat.toString());
                                                    prefs.setString('Owner_Name', abc.data![len].Ownername.toString());
                                                    prefs.setString('Owner_Number', abc.data![len].Owner_number.toString());
                                                    prefs.setString('fieldworkarname', abc.data![len].fieldworkarname.toString());
                                                    prefs.setString('fieldworkarnumber', abc.data![len].fieldworkarnumber.toString());
                                                    prefs.setString('property_image', abc.data![len].Building_image.toString());
                                                    prefs.setString('maintence', abc.data![len].maintence.toString());
                                                    prefs.setString('bhk_bhk', abc.data![len].BHK.toString());
                                                    //prefs.setString('Owner_no', abc.data![len].Owner_number.toString());
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute
                                                          (builder: (context) => TenantDetails())
                                                    );
                                                    /*_showBottomSheet(context, "${abc.data![len].id.toString()}");
                                                  print("${abc.data![len].id}");*/

                                                    /*Navigator.push(
                                            context,
                                            MaterialPageRoute
                                              (builder: (context) => Add_review_Under_feedback_T_Demand(idd: '${abc.data![len].id}',))
                                        );*/

                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                                    decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(10),
                                                            bottomRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10)),
                                                        color: Colors.red.withOpacity(0.8)),
                                                    child: Center(
                                                      child: Text(
                                                        "Add Tenant",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            letterSpacing: 0.8,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              );
                            });
                      }


                    }

                ),

              ),
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Book_Property()));
        },
      ),*/
    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data1 = prefs.getString('id_Document') ?? '';
      _Owner_Number = prefs.getString('Owner_Number') ?? '';
      _number = prefs.getString('number') ?? '';
    });


  }

}