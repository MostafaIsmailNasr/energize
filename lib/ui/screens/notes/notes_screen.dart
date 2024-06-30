import 'package:energize_flutter/business/notesController/NotesController.dart';
import 'package:energize_flutter/ui/widget_Items_list/NotesItemList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../conustant/AppLocale.dart';
import '../../../conustant/my_colors.dart';
import '../shipment_details/shipment_details_screen.dart';

class NotesScreen extends StatefulWidget{
  var orderId;

  NotesScreen({required this.orderId});

  @override
  State<StatefulWidget> createState() {
    return _NotesScreen();
  }
}

class _NotesScreen extends State<NotesScreen> {
  final notesController=Get.put(NotesController());

  @override
  void initState() {
    notesController.getNotes(widget.orderId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Directionality(
                    textDirection: notesController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) {
                            //       return ShipmentDetailsScreen();
                            //     }));
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios, color: MyColors.Dark1)),
                      title: Text(
                        "${getLang(context, "notes")}",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'din_next_arabic_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                        textAlign: TextAlign.start,
                      ),
                      backgroundColor: MyColors.DarkWHITE,
                    ),
                    body: Obx(() =>!notesController.isLoading.value? Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child: notesList(),
                          ),
                        ],
                      ),
                    )
                        :Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS,))),


                  ),
                );
              } else {
                return  Scaffold(body: NoIntrnet());
              }
            },
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.MAINCOLORS,
              ),
            ),
          ),
      ),
    );
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/internet.svg'),
          const SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_internet")}",
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget notesList(){
    if(notesController.NotesList.isNotEmpty){
      return  ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: notesController.NotesList.length,
          itemBuilder: (context, int index) {
            return NotesItemList(
              des: "${getLang(context, 'Do_you_want_to_confirm_the_deletion_notes')}",
              notes: notesController.NotesList[index],
              orderId: widget.orderId,
            );
          });
    }else{
      return emptyDriver();
    }
  }
}

class emptyDriver extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/error_img.svg'),
            SizedBox(height: 10,),
            Text("${getLang(context, "There_are_no_notes")}",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text("${getLang(context, "You_havent_added_any_notes")}",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}