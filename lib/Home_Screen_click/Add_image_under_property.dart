import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
import '../doctenantdetailsSlider.dart';
import 'Delete_Image.dart';
import 'Edit_Page_Realestate.dart';
import 'View_All_Details.dart';

class Catid {
  final String property_num;

  Catid(
      {required this.property_num});

  factory Catid.FromJson(Map<String, dynamic>json){
    return Catid(
        property_num: json['imagepath']);
  }
}

class FileUploadPage extends StatefulWidget {
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {

  bool _isLoading = false;

/*  void _handleButtonClick() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or any async task
    await Future.delayed(Duration(seconds: 10));

    setState(() {
      _isLoading = false;
    });
  }*/

  File? _imageFile;
  final TextEditingController _nameController = TextEditingController();

  int _id = 0;
  String _Longitude = '';
  String _Latitude = '';

  static Future<void> openMap(double latitude,double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if(await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    super.initState();
    _loaduserdata();
  }

  /*Future<List<DocumentTenantDetailsModel>> fetchCarouselData() async {
    final response = await http.get(Uri.parse('https://verifyserve.social/WebService4.asmx/Show_Image_under_Realestatet?id_num=Suraj'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) {
        return DocumentTenantDetailsModel(
          timage: item['imagepath'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }*/

  Future<List<Catid>> fetchData() async {
    var url = Uri.parse("https://verifyserve.social/WebService4.asmx/Show_Image_under_Realestatet?id_num=$_id");
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      List listresponce = json.decode(responce.body);
      return listresponce.map((data) => Catid.FromJson(data)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<File?> pickAndCompressImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return null;

    final tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.path}/verify_${DateTime.now().millisecondsSinceEpoch}.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      pickedFile.path,
      targetPath,
      quality: 85, // Compression quality
    );

    return result;
  }

  Future<void> uploadImageWithTitle(File imageFile, String title) async {
    String uploadUrl = 'https://verifyserve.social/upload.php'; // Replace with your API endpoint

    FormData formData = FormData.fromMap({
      "name": title,
      "image": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    });

    Dio dio = Dio();

    try {
      Response response = await dio.post(uploadUrl, data: formData);
      if (response.statusCode == 200) {
      setState(() {
          _imageFile = null;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful: ${response.data}')),
        );
        print('Upload successful: ${response.data}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.statusCode}')),
        );
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
      print('Error occurred: $e');
    }
  }

  Future<void> _handleUpload() async {
    if (_imageFile == null) {
      Fluttertoast.showToast(
          msg: "Image are required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image and enter a title')),
      );
      return;
    }

    await uploadImageWithTitle(_imageFile!, _id.toString());
  }

  String data = 'Initial Data';

  void _refreshData() {
    setState(() {
      data = 'Refreshed Data at ${DateTime.now()}';
    });
  }

  late String googleMapsUrl;

  bool _shouldRefresh = false;

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
              final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Delete_Image()));

               if (result == true) {
                 _refreshData();
               }
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
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                        onPressed: () async {
                          File? pickedImage = await pickAndCompressImage();
                          if (pickedImage != null) {
                            setState(() {
                              _imageFile = pickedImage;
                            });
                          }
                        },
                        child: Text('Pick Image'),
                      ),

                      SizedBox(
                        width: 100,
                      ),

                      Container(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: _imageFile != null
                              ? Image.file(_imageFile!)
                              : Text('No image selected.',style: TextStyle(color: Colors.white),),
                        ),
                      ),

                    ],
                  ),


                  SizedBox(height: 0),
                  GestureDetector(
                    onTap: () async {
                      _handleUpload();
                      setState(() {
                        _isLoading = true;
                      });

                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 200,
                        // margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.red.withOpacity(0.8)),
                        child: _isLoading
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : const Center(
                          child: Text(
                            "Upload Image",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),


                  FutureBuilder<List<Catid>>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Center(child: Text('No data available.'));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context,int len){
                            return Container(
                              margin: const EdgeInsets.only(right: 10, bottom: 20),
                              width: 100,
                              height: 400,
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "https://www.verifyserve.social/${snapshot.data![len].property_num}",
                                  fit: BoxFit.fitWidth,
                                  placeholder: (context, url) => Image.asset(
                                    AppImages.loading,
                                    fit: BoxFit.none,
                                  ),
                                  errorWidget: (context, error, stack) =>
                                      Image.asset(
                                        AppImages.imageNotFound,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            );
                          }
                        );



                      }
                    },
                  ),

                  Text("Hello"+_Longitude,style: TextStyle(color: Colors.white),),
                  Text(_Latitude, style: TextStyle(color: Colors.white),),

                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Edit_Page_realestate()));
                // Button 1 action
                print('Button 1 pressed');
              },
              child: Text('Edit Property',style: TextStyle(fontSize: 15),),
            ),
          ),
          SizedBox(width: 6), // Space between buttons
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                // Button 2 action

                /*Fluttertoast.showToast(
                    msg: "Image and name are required",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0
                );*/



                String lat = '${_Latitude}';
                String long = '${_Longitude}';

                double latitude = double.parse(lat.replaceAll(RegExp(r'[^0-9.]'),''));

                double longitude = double.parse(long.replaceAll(RegExp(r'[^0-9.]'),''));

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text('Opening Map'),
                      content: Container(
                          height: 50,
                          child: Center(child: CircularProgressIndicator())),
                    );
                  },
                );

                Future.delayed(Duration(seconds: 2), () {
                  // Close the loading dialog
                  Navigator.of(context).pop();

                  // Navigate to Google Maps or your desired location
                  openMap(longitude,latitude);
                });

              },
              child: Text('Open Google Map',style: TextStyle(fontSize: 15)),
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
      _Longitude = prefs.getString('id_Longitude') ?? '';
      _Latitude = prefs.getString('id_Latitude') ?? '';
    });


  }

  void _launchMaps() async {
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

}
