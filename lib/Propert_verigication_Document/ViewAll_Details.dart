import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Police_Verification/Owner_Details.dart';
import '../constant.dart';
import '../model/docpropertySlider.dart';

class Catid {
  final int id;
  final String property_num;
  final String Address_;
  final String Place_;
  final String sqft;
  final String Price;
  final String Sell_price;
  final String Persnol_price;
  final String maintenance;
  final String Buy_Rent;
  final String Residence_Commercial;
  final String floor_ ;
  final String flat_;
  final String Furnished;
  final String Details;
  final String Ownername;
  final String Owner_number;
  final String Building_information;
  final String balcony;
  final String kitchen;
  final String Baathroom;
  final String Parking;
  final String Typeofproperty;
  final String Bhk_Squarefit;
  final String Address_apnehisaabka;
  final String Caretaker_name;
  final String Caretaker_number;
  final String Building_Location;
  final String Building_Name;
  final String Building_Address;
  final String Building_image;
  final String Longitude;
  final String Latitude;
  final String Rent;
  final String Verify_price;
  final String BHK;
  final String tyope;
  final String maintence ;
  final String buy_Rent ;
  final String facility;
  final String Feild_name ;
  final String Feild_number;
  final String date;

  Catid(
      {required this.id,required this.property_num,required this.Address_,required this.Place_,required this.sqft,
        required this.Price,required this.Sell_price,required this.Persnol_price,required this.maintenance,
        required this.Buy_Rent,required this.Residence_Commercial,required this.floor_,required this.flat_,
        required this.Furnished,required this.Details,required this.Ownername,required this.Owner_number,
        required this.Building_information,required this.balcony,required this.kitchen,required this.Baathroom,
        required this.Parking,required this.Typeofproperty,required this.Bhk_Squarefit,required this.Address_apnehisaabka,
        required this.Caretaker_name,required this.Caretaker_number, required this.Building_Location, required this.Building_Name, required this.Building_Address, required this.Building_image, required this.Longitude, required this.Latitude, required this.Rent, required this.Verify_price, required this.BHK, required this.tyope, required this.maintence, required this.buy_Rent,
        required this.facility,required this.Feild_name,required this.Feild_number,required this.date});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['PVR_id'],
        property_num: json['Property_Number'], Address_: json['Address_'],
        Place_: json['Place_'], sqft: json['City'],
        Price: json['Price'], Sell_price: json['Waterfilter'],
        Persnol_price: json['Gas_meter'], maintenance: json['maintenance'],
        Buy_Rent: json['Buy_Rent'], Residence_Commercial: json['Residence_Commercial'],
        floor_: json['floor_'], flat_: json['flat_'],
        Furnished: json['Furnished'], Details: json['Details'],
        Ownername: json['Ownername'], Owner_number: json['Owner_number'],
        Building_information: json['Building_information'], balcony: json['balcony'],
        kitchen: json['kitchen'], Baathroom: json['Baathroom'],
        Parking: json['Parking'], Typeofproperty: json['Typeofproperty'],
        Bhk_Squarefit: json['Bhk_Squarefit'], Address_apnehisaabka: json['Address_apnehisaabka'],
        Caretaker_name: json['Water_geyser'], Caretaker_number: json['CareTaker_number'], Building_Location: json['Place_'],
        Building_Name: json['Building_information'],
        Building_Address: json['Address_'],
        Building_image: json['Realstate_image'],
        Longitude: json['Longtitude'],
        Latitude: json['Latitude'],
        Rent: json['Property_Number'],
        Verify_price: json['Gas_meter'],
        BHK: json['Bhk_Squarefit'],
        tyope: json['Typeofproperty'],
        maintence: json['maintenance'],
        buy_Rent: json['Buy_Rent'],
        facility: json['Lift'],
        Feild_name: json['fieldworkarname'],
        Feild_number: json['fieldworkarnumber'],
        date: json['date_']);
  }
}

class Catid_details {
  final String Reelestate_Image;
  final String Address_;
  final String Place_;
  final String floor_ ;
  final String flat_;
  final String Tenant_Rented_Amount;
  final String Tenant_Rented_Date;
  final String maintence;
  final String Bhk_Squarefit;
  final String Tenant_Name;
  final String Tenant_Number;
  final String Tenant_Email;
  final String Tenant_WorkProfile;
  final String Tenant_Members;
  final String Property_Number;
  final String Looking_Prop_;
  final String Subid;

  Catid_details(
      {required this.Reelestate_Image,required this.Address_,required this.Place_,required this.floor_,required this.flat_,
        required this.Tenant_Rented_Amount,required this.Tenant_Rented_Date,required this.maintence,required this.Bhk_Squarefit,
        required this.Tenant_Name,required this.Tenant_Number,required this.Tenant_Email,required this.Tenant_WorkProfile,
        required this.Tenant_Members,required this.Property_Number,required this.Looking_Prop_,required this.Subid});

  factory Catid_details.FromJson(Map<String, dynamic>json){
    return Catid_details(Address_: json['Property_Number'],
        Reelestate_Image: json['Property_Image'],Place_: json['PropertyAddress'],
        floor_: json['FLoorr'], flat_: json['Flat'],
        Tenant_Rented_Amount: json['Tenant_Rented_Amount'], Tenant_Rented_Date: json['Tenant_Rented_Date'],
        maintence: json['Looking_Prop_'], Bhk_Squarefit: json['About_tenant'],
        Tenant_Name: json['Tenant_Name'],Tenant_Number: json['Tenant_Number'],
        Tenant_Email: json['Tenant_Email'], Tenant_WorkProfile: json['Tenant_WorkProfile'],
        Tenant_Members: json['Tenant_Members'], Property_Number: json['Property_Number'],
        Looking_Prop_: json['Looking_Prop_'], Subid: json['Subid']);
  }
}


class View_Detailsdocs extends StatefulWidget {
  final String iidd;
  final String SUbid;
  const View_Detailsdocs({Key? key, required this.iidd, required this.SUbid}) : super(key: key);

  @override
  State<View_Detailsdocs> createState() => _View_DetailsdocsState();
}

class _View_DetailsdocsState extends State<View_Detailsdocs> {

  Future<List<Catid>> fetchData() async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/Show_proprty_realstate_by_originalid?PVR_id=${widget.SUbid}");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid_details>> fetchData_Tenant_Detail() async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/Show_Verify_AddTenant_Under_Property_Table_by_id_?TUP_id=${widget.iidd}");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid_details.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<DocumentMainModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService4.asmx/Show_Image_under_Realestatet?id_num=${widget.SUbid}'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return DocumentMainModel(
          dimage: item['imagepath'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> Book_property() async{
    final responce = await http.get(Uri.parse('https://verifyserve.social/WebService4.asmx/Update_Book_Realestate_by_feildworker?idd=${widget.SUbid}&looking=Flat'));
    //final responce = await http.get(Uri.parse('https://verifyserve.social/WebService2.asmx/Add_Tenants_Documaintation?Tenant_Name=gjhgjg&Tenant_Rented_Amount=entamount&Tenant_Rented_Date=entdat&About_tenant=bout&Tenant_Number=enentnum&Tenant_Email=enentemail&Tenant_WorkProfile=nantwor&Tenant_Members=enentmember&Owner_Name=wnername&Owner_Number=umb&Owner_Email=emi&Subid=3'));

    if(responce.statusCode == 200){
      print(responce.body);

      //SharedPreferences prefs = await SharedPreferences.getInstance();

    } else {
      print('Failed Registration');
    }

  }

  bool _isDeleting = false;

  //Delete api
  Future<void> DeletePropertybyid(itemId) async {
    final url = Uri.parse('https://verifyserve.social/WebService4.asmx/Verify_Property_Verification_delete_by_id?PVR_id=${widget.SUbid}');
    final response = await http.get(url);
    // await Future.delayed(Duration(seconds: 1));
    if (response.statusCode == 200) {
      setState(() {
        _isDeleting = false;
        //ShowVehicleNumbers(id);
        //showVehicleModel?.vehicleNo;
      });
      print(response.body.toString());
      print('Item deleted successfully');
    } else {
      print('Error deleting item. Status code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  // final result = await fetchData();

  List<String> name = [];

  // late final int iid;

  int _id = 0;

  @override
  void initState() {
    super.initState();
    _loaduserdata();

  }

  String data = 'Initial Data';

  void _refreshData() {
    setState(() {
      data = 'Refreshed Data at ${DateTime.now()}';
    });
  }

//  final result = await profile();

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
        actions:  [
          GestureDetector(
            onTap: () async {

              showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Property'),
                  content: Text('Do you really want to Delete This Property?'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.black,
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final result_delete = await fetchData();
                        print(result_delete.first.id);
                        DeletePropertybyid('${result_delete.first.id}');
                        setState(() {
                          _isDeleting = true;
                        });
                        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Show_realestete(),), (route) => route.isFirst);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ) ?? false;
              /*final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Delete_Image()));

              if (result == true) {
                _refreshData();
              }*/
            },
            child: const Icon(
              PhosphorIcons.trash,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [


              FutureBuilder<List<Catid_details>>(
                  future: fetchData_Tenant_Detail(),
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
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context,int len){
                            return GestureDetector(
                              onTap: () async {

                              },
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [

                                          FutureBuilder<List<DocumentMainModel>>(
                                            future: fetchCarouselData(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(child: CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return Center(child: Text('Error: ${snapshot.error}'));
                                              } else if (!snapshot.hasData) {
                                                return Center(child: Text('No data available.'));
                                              } else {
                                                return CarouselSlider(
                                                  options: CarouselOptions(
                                                    height: 180.0,
                                                    enlargeCenterPage: true,
                                                    autoPlay: true,
                                                    autoPlayInterval: const Duration(seconds: 2),
                                                  ),
                                                  items: snapshot.data!.map((item) {
                                                    return Builder(
                                                      builder: (BuildContext context) {
                                                        return  Container(
                                                          margin: const EdgeInsets.only(right: 10),
                                                          width: 320,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            const BorderRadius.all(Radius.circular(15)),
                                                            child: CachedNetworkImage(
                                                              imageUrl:
                                                              "https://www.verifyserve.social/${item.dimage}",
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
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                );
                                              }
                                            },
                                          ),

                                          const SizedBox(height: 20,),

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

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
                                                            Text("Flat No - "+abc.data![len].flat_/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                              style: TextStyle(
                                                                  fontSize: 14,
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
                                                            //w SizedBox(width: 10,),
                                                            Text(""+abc.data![len].floor_/*+abc.data![len].Building_Name.toUpperCase()*/,
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



                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.teal),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.teal.withOpacity(0.5),
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
                                                            Text(""+abc.data![len].Bhk_Squarefit/*+abc.data![len].Building_Name.toUpperCase()*/,
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

                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),



                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Center(
                                                        child: Text("Property Tenant",style: TextStyle(fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600),),
                                                      ),

                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 140,
                                                              padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(width: 1, color: Colors.indigoAccent),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors.indigoAccent.withOpacity(0.5),
                                                                      blurRadius: 10,
                                                                      offset: Offset(0, 0),
                                                                      blurStyle: BlurStyle.outer
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  // Icon(Iconsax.sort_copy,size: 15,),
                                                                  //SizedBox(width: 10,),
                                                                  Text(""+abc.data![len].Tenant_Name/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.w500,
                                                                        letterSpacing: 0.5
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              width: 20,
                                                            ),

                                                            GestureDetector(
                                                              onTap: (){

                                                                showDialog<bool>(
                                                                  context: context,
                                                                  builder: (context) => AlertDialog(
                                                                    title: Text('Call Property tenant'),
                                                                    content: Text('Do you really want to Call Tenant?'),
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                    actions: <Widget>[
                                                                      ElevatedButton(
                                                                        onPressed: () => Navigator.of(context).pop(false),
                                                                        child: Text('No'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed: () async {
                                                                          FlutterPhoneDirectCaller.callNumber('${abc.data![len].Tenant_Number}');
                                                                        },
                                                                        child: Text('Yes'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ) ?? false;
                                                              },
                                                              child: Container(
                                                                width: 140,
                                                                padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  border: Border.all(width: 1, color: Colors.indigoAccent),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors.indigoAccent.withOpacity(0.5),
                                                                        blurRadius: 10,
                                                                        offset: Offset(0, 0),
                                                                        blurStyle: BlurStyle.outer
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    // Icon(Iconsax.sort_copy,size: 15,),
                                                                    //SizedBox(width: 10,),
                                                                    Text(""+abc.data![len].Tenant_Number/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                                      style: TextStyle(
                                                                          fontSize: 14,
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
                                                      Text("Building Rent & Maintaince",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 180,
                                                        child: Text(""+abc.data![len].Tenant_Rented_Amount+"  |  "+abc.data![len].maintence,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,

                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w700),
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
                                                      Text("Shifting Date",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text('${abc.data![len].Tenant_Rented_Date}',
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,

                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w700),
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
                                                      Text("Tenant Living Members",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text('${abc.data![len].Tenant_Members} Members',
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,

                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w700),
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
                                                      Text("Tenant Work Profile",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text('${abc.data![len].Tenant_WorkProfile}',
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,

                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w700),
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
                                                      Text("Tenant Email",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text('${abc.data![len].Tenant_Email}',
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,

                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w700),
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
                                                      Text("Tenant Vehicle Details",
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text('Vehicle no comming soon',
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 14,

                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w700),
                                                        ),
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
                                                          border: Border.all(width: 1, color: Colors.indigo),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.indigo.withOpacity(0.5),
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
                                                            Text(""+abc.data![len].Place_/*+abc.data![len].Building_Name.toUpperCase()*/,
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

                                                      Container(
                                                        padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 1, color: Colors.brown),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.brown.withOpacity(0.5),
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
                                                            Text("RENT"/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                        width: 15,
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
                                                            //w SizedBox(width: 10,),
                                                            Text(""+abc.data![len].Looking_Prop_.toUpperCase()/*+abc.data![len].Building_Name.toUpperCase()*/,
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
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 20,
                                                  ),








                                                ],
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

              FutureBuilder<List<Catid>>(
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
                            // Lottie.asset("assets/images/no data.json",width: 450),
                            Text("No Data Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                          ],
                        ),
                      );
                    }
                    else{
                      return ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context,int len){
                            return Padding(
                              padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Center(
                                      child: Text("Property owner",style: TextStyle(fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: 150,
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
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //SizedBox(width: 10,),
                                              Text(""+abc.data![len].Ownername/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width: 20,
                                        ),

                                        GestureDetector(
                                          onTap: (){

                                            showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('Call Property Owner'),
                                                content: Text('Do you really want to Call Owner?'),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: Text('No'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      FlutterPhoneDirectCaller.callNumber('${abc.data![len].Owner_number}');
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            ) ?? false;
                                          },
                                          child: Container(
                                            width: 150,
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Icon(Iconsax.sort_copy,size: 15,),
                                                //SizedBox(width: 10,),
                                                Text(""+abc.data![len].Owner_number/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                  style: TextStyle(
                                                      fontSize: 14,
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

                                    Center(
                                      child: Text("CareTaker Info",style: TextStyle(fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.cyanAccent),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.cyanAccent.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //SizedBox(width: 10,),
                                              Text(""+abc.data![len].Caretaker_name/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width: 20,
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('Call Property CareTaker'),
                                                content: Text('Do you really want to Call CareTaker?'),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: Text('No'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      FlutterPhoneDirectCaller.callNumber('${abc.data![len].Caretaker_number}');
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            ) ?? false;
                                          },
                                          child: Container(
                                            width: 150,
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: 1, color: Colors.cyanAccent),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.cyanAccent.withOpacity(0.5),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0),
                                                    blurStyle: BlurStyle.outer
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Icon(Iconsax.sort_copy,size: 15,),
                                                //SizedBox(width: 10,),
                                                Text(""+abc.data![len].Caretaker_number/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                  style: TextStyle(
                                                      fontSize: 14,
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
                                        Text("Building Rent & Maintaince Demand By Owner",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(""+abc.data![len].Rent+"  |  "+abc.data![len].maintence,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 14,

                                                color: Colors.red,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Sqft | Balcony & Parking",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(""+abc.data![len].sqft+"  |  "+abc.data![len].balcony+"  |  "+abc.data![len].Parking+" Parking" ,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
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
                                        Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Building Information & facilitys",
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(""+abc.data![len].Building_information,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
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
                                        Icon(PhosphorIcons.push_pin,size: 13,color: Colors.red,),
                                        SizedBox(width: 5,),
                                        Text("Property Name & Address",
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(""+abc.data![len].Address_,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
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
                                        Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Property Floor | Flat Number",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(""+abc.data![len].floor_+"  |  "+abc.data![len].flat_,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
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
                                        Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Building facilities",
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(""+abc.data![len].facility,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
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
                                        Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Furnished | Furnished Details",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(""+abc.data![len].Furnished+"  |  "+abc.data![len].Details,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
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
                                        Icon(Iconsax.home_1_copy,size: 12,color: Colors.red,),
                                        SizedBox(width: 2,),
                                        Text("Kitchen | Bathroom",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(""+abc.data![len].kitchen+" Kitchen  |  "+abc.data![len].Baathroom+" Bathroom",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12 ,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                              //w SizedBox(width: 10,),
                                              Text("Property Id = "+abc.data![len].id.toString()/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 14,
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

                                    Center(
                                      child: Text("Feild Worker",style: TextStyle(fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.yellow),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.yellow.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //SizedBox(width: 10,),
                                              Text(""+abc.data![len].Feild_name/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.5
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          width: 20,
                                        ),

                                        Container(
                                          width: 150,
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1, color: Colors.yellow),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.yellow.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0),
                                                  blurStyle: BlurStyle.outer
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Icon(Iconsax.sort_copy,size: 15,),
                                              //SizedBox(width: 10,),
                                              Text(""+abc.data![len].Feild_number/*+abc.data![len].Building_Name.toUpperCase()*/,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
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
                            );
                          }
                      );

                    }

                  }
              )

            ],
          ),






        ),
      ),

      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: () async {
                final result_Tenanted_property = await fetchData();
                final Tenanted_property = await fetchData_Tenant_Detail();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('B_Sibid_', result_Tenanted_property.first.id);
                prefs.setString('B_Ownername_', result_Tenanted_property.first.Ownername);
                prefs.setString('B_Ownernumber_', result_Tenanted_property.first.Owner_number);
                prefs.setString('B_Tenantname_', Tenanted_property.first.Tenant_Name);
                prefs.setString('B_Tenantnumber_', Tenanted_property.first.Tenant_Number);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Owner_details(iid: '${result_Tenanted_property.first.id.toString()}',)),
                );
              },
              child: Text('Apply Document',style: TextStyle(fontSize: 13),),
            ),
          ),
          SizedBox(width: 6), // Space between buttons
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                // Button 2 action

                //Book_property();

                /*showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Move to Real-Estate'),
                    content: Text('Do you really want to Move This property for Rent?'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Book_property();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Show_realestete(),), (route) => route.isFirst);

                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                ) ?? false;*/

                print('Button 2 pressed');
              },
              child: Text('Move To Real-Estate',style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),

    );
  }
  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _id = prefs.getInt('id_Building') ?? 0;
    });


  }

  void _launchDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

}
