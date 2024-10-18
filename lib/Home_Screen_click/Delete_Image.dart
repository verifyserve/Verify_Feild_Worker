import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verify_feild_worker/Home_Screen_click/showVehicle.dart';

import '../constant.dart';

class Delete_Image extends StatefulWidget {
  const Delete_Image({super.key});

  @override
  State<Delete_Image> createState() => _Delete_ImageState();
}

class _Delete_ImageState extends State<Delete_Image> {

  int _id = 0;

  bool _isDeleting = false;

  //Delete api
  Future<void> DeleteVehicleNumbers(itemId) async {
    final url = Uri.parse('https://verifyserve.social/WebService4.asmx/Delete_Added_images_realestate?idd=$itemId');
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

  Future<List<ShowVehicleModel>> ShowVehicleNumbers(id) async {
    final url = Uri.parse('https://verifyserve.social/WebService4.asmx/Show_Image_under_Realestatet?id_num=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //await Future.delayed(Duration(seconds: 2));
      final List result = json.decode(response.body);
      print(response.body.toString());
      return result.map((e) => ShowVehicleModel.fromJson(e)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  void initState() {
    super.initState();
    _loaduserdata();
  }

  bool _shouldRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 30),
            child: FutureBuilder(
              future: ShowVehicleNumbers(_id),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: LinearProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  // If the list is empty, show an empty image
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  Lottie.asset("assets/images/no data.json",width: 450),
                        Text("No Image Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins',letterSpacing: 0),),
                      ],
                    ),
                  );
                }
                else{
                  return _isDeleting
                      ? Center(child: RefreshProgressIndicator())
                      :
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                height: 190,
                                width: 120,
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "https://verifyserve.social/${snapshot.data![index].image_ji}",
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
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: Colors.grey.shade100
                              ),
                              child: IconButton(onPressed: (){
                                showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Delete Image'),
                                    content: Text('Do you really want to Delete This Image?'),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text('No'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          DeleteVehicleNumbers('${snapshot.data![index].iid}');
                                          setState(() {
                                            _isDeleting = true;
                                          });
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                                ) ?? false;
                              }, icon: Icon(PhosphorIcons.trash,size: 20,),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },),
          ),
        ),
      ),
    );
  }

  void _loaduserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _id = prefs.getInt('id_Building') ?? 0;
    });


  }

}
