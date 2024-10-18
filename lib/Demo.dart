import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'Police_Verification/Owner_Details.dart';
import 'constant.dart';
import 'model/realestateModel.dart';


class Catid {
  final int id;
  final String Building_Name;
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
  final String Caretaker_name;
  final String Caretaker_number;

  Catid(
      {required this.id, required this.Building_Name, required this.Building_Address, required this.Building_Location, required this.Building_image, required this.Longitude, required this.Latitude, required this.Rent, required this.Verify_price, required this.BHK, required this.sqft, required this.tyope, required this.floor_, required this.maintence, required this.buy_Rent,
        required this.Building_information,required this.balcony,required this.Parking,required this.facility,required this.Furnished,required this.kitchen,required this.Baathroom,required this.Ownername,required this.Owner_number,
        required this.Caretaker_name,required this.Caretaker_number});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(id: json['PVR_id'],
        Building_Name: json['Building_information'],
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
        Caretaker_name: json['Water_geyser'],
        Caretaker_number: json['CareTaker_number']);
  }
}


class SliverListExample extends StatefulWidget {
  @override
  _SliverListExampleState createState() => _SliverListExampleState();
}

class _SliverListExampleState extends State<SliverListExample> {


  Future<List<Catid>> fetchData1() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Flat&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Catid>> fetchData2() async {
    var url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_typeofproperty_lookingproperty?Typeofproperty=Shop&Looking_Property_=Flat');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      listresponce.sort((a, b) => b['PVR_id'].compareTo(a['PVR_id']));
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  //For Real Estate Slider
  Future<List<RealstateModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService1.asmx/ShowRealestateimg'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return RealstateModel(
          rimage: item['Rimage'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showBottomSheet(BuildContext context) {

    List<String> timing = [
      "Residential",
      "Plots",
      "Commercial",
    ];
    ValueNotifier<int> timingIndex = ValueNotifier(0);

    String displayedData = "Press a button to display data";

    void updateData(String newData) {
      setState(() {
        displayedData = newData;
      });
    }

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return  DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.all(3),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: Colors.grey),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(text: 'Residential'),
                      Tab(text: 'Commercial'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    /*Owner_details(),
                    Owner_details()*/
                    /*Residential_filter(),
                    Residential_filter()*/
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
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
            Navigator.pop(context, true);

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
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Delete_Image()));
            },
            child: const Icon(
              PhosphorIcons.trash,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<RealstateModel>>(
                  future: fetchCarouselData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data available.'));
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CarouselSlider(
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
                                      "https://www.verifyserve.social/upload/${item.rimage}",
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
                        ),
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Container(
                  height: 45,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: (){
                      _showBottomSheet(context);
                    },
                    child: Text(
                      "Find Property",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData1(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Flat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return Container(
                                  width: 300,
                                  margin: EdgeInsets.only(
                                      bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 170,
                                        width: 300,
                                        child:ClipRRect(
                                          borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                          child:  CachedNetworkImage(
                                            imageUrl:
                                            "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                            // height: 60.h,
                                            // width: 120.w,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Image.asset(
                                              AppImages.loading,
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (context, error, stack) =>
                                                Image.asset(
                                                  AppImages.imageNotFound,
                                                  // height: 60.h,
                                                  // width: 120.w,
                                                  fit: BoxFit.cover,
                                                ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text("${abc.data![len].tyope} With ${abc.data![len].balcony} Balcony" ,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13,
                                                      color: Colors.black
                                                  ),
                                                )
                                            ),
                                            Text(
                                              ""+abc.data![len].buy_Rent,
                                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7),
                                        width: 310,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            Text(""+abc.data![len].Building_Location,style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                                color: Colors.black
                                            ),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          "₹ ${abc.data![len].Rent}",
                                          style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData2(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Shops',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return Container(
                                  width: 300,
                                  margin: EdgeInsets.only(
                                      bottom: 10, top: index == 0 ? 10 : 10, left:5, right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 170,
                                        width: 300,
                                        child:ClipRRect(
                                          borderRadius: const BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5)),
                                          child:  CachedNetworkImage(
                                            imageUrl:
                                            "https://www.verifyserve.social/${abc.data![len].Building_image}",
                                            // height: 60.h,
                                            // width: 120.w,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Image.asset(
                                              AppImages.loading,
                                              // height: 60.h,
                                              // width: 120.w,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (context, error, stack) =>
                                                Image.asset(
                                                  AppImages.imageNotFound,
                                                  // height: 60.h,
                                                  // width: 120.w,
                                                  fit: BoxFit.cover,
                                                ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text("${abc.data![len].tyope} With ${abc.data![len].balcony} Balcony" ,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13,
                                                    color: Colors.black
                                                  ),
                                                )
                                            ),
                                            Text(
                                              ""+abc.data![len].buy_Rent,
                                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7),
                                        width: 310,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            Text(""+abc.data![len].Building_Location,style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                                color: Colors.black
                                            ),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          "₹ ${abc.data![len].Rent}",
                                          style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          /*SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData1(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Flat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 340,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 5,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
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
                                                          Text(""+abc.data![len].V_name*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].V_number*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Type Of Requirement / Floor Options / Shifting Date",
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].bhk*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].floor_option*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Shifting_date*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Need Parking / Vehicle Number",
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Parking*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Gadi_Number.toUpperCase(),
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Additional Information",
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: Text(""+abc.data![len].Family_Members+"  |  "+abc.data![len].Additional_Info,
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
                                                    Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Budget / Location / For Rent & Buy",
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
                                                          Text(""+abc.data![len].budget*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].place*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].bhk*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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

                                                SizedBox(height: 10,),

                                                Center(
                                                  child: Text("Field Worker",style: TextStyle(fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600),),
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
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
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Icon(Iconsax.sort_copy,size: 15,),
                                                          //SizedBox(width: 10,),
                                                          Text(""+abc.data![len].FeildWorker_Name*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].FeildWorker_Number*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),

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
                                                      Text("Property id =  "+abc.data![len].id.toString()*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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


                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData2(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Flat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 340,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 5,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
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
                                                          Text(""+abc.data![len].V_name*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].V_number*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Type Of Requirement / Floor Options / Shifting Date",
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].bhk*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].floor_option*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Shifting_date*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Need Parking / Vehicle Number",
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Parking*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Gadi_Number.toUpperCase(),
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Additional Information",
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: Text(""+abc.data![len].Family_Members+"  |  "+abc.data![len].Additional_Info,
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
                                                    Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Budget / Location / For Rent & Buy",
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
                                                          Text(""+abc.data![len].budget*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].place*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].bhk*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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

                                                SizedBox(height: 10,),

                                                Center(
                                                  child: Text("Field Worker",style: TextStyle(fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600),),
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
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
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Icon(Iconsax.sort_copy,size: 15,),
                                                          //SizedBox(width: 10,),
                                                          Text(""+abc.data![len].FeildWorker_Name*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].FeildWorker_Number*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),

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
                                                      Text("Property id =  "+abc.data![len].id.toString()*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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


                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return FutureBuilder<List<Catid>>(
                  future: fetchData2(),
                  builder: (context, abc) {
                    if (abc.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (abc.hasError) {
                      return Center(child: Text('Error: ${abc.error}'));
                    } else if (!abc.hasData || abc.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      final data = abc.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'For Flat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 340,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context,int len) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 5,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
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
                                                          Text(""+abc.data![len].V_name*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].V_number*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Iconsax.location_copy,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Type Of Requirement / Floor Options / Shifting Date",
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].bhk*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].floor_option*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Shifting_date*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(PhosphorIcons.push_pin,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Need Parking / Vehicle Number",
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Parking*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          //w SizedBox(width: 10,),
                                                          Text(""+abc.data![len].Gadi_Number.toUpperCase(),
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Additional Information",
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
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: Text(""+abc.data![len].Family_Members+"  |  "+abc.data![len].Additional_Info,
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
                                                    Icon(PhosphorIcons.address_book,size: 12,color: Colors.red,),
                                                    SizedBox(width: 2,),
                                                    Text("Budget / Location / For Rent & Buy",
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
                                                          Text(""+abc.data![len].budget*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].place*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].bhk*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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

                                                SizedBox(height: 10,),

                                                Center(
                                                  child: Text("Field Worker",style: TextStyle(fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600),),
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
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
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Icon(Iconsax.sort_copy,size: 15,),
                                                          //SizedBox(width: 10,),
                                                          Text(""+abc.data![len].FeildWorker_Name*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                          Text(""+abc.data![len].FeildWorker_Number*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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
                                                  height: 5,
                                                ),

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
                                                      Text("Property id =  "+abc.data![len].id.toString()*//*+abc.data![len].Building_Name.toUpperCase()*//*,
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


                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: 1, // Number of categories
            ),
          ),*/


        ],
      ),

    );
  }
}
