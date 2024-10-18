import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../Future_Property_OwnerDetails_section/Future_Property.dart';
import '../constant.dart';
import 'Common_Filter_Residential.dart';
import 'Common_filter_WithFloor.dart';

class Filter_Options extends StatefulWidget {
  const Filter_Options({super.key});

  @override
  State<Filter_Options> createState() => _Filter_OptionsState();
}

class _Filter_OptionsState extends State<Filter_Options> {


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
                      Tab(text: 'Common Filter'),
                      Tab(text: 'With Floor'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    //Residential_filter(),
                    //Residential_filter()
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String displayedText = "Data 1";

  void changeData(String newText) {
    setState(() {
      displayedText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: [
              Tab(text: 'Common Filter'),
              Tab(text: 'Floor Option'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Residential_filter(),
          Residential_filter_withfloor(),
          ],
        ),
      ),
    );
  }
}
