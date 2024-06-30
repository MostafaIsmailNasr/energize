import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../business/updateStatusController/updateStatusController.dart';
import '../../../../data/model/shipmentCategoryDetailsModel/ShipmentCategoryDetailsResponse.dart';

import '../../../../conustant/AppLocale.dart';
import '../../../../conustant/my_colors.dart';

enum dateGroup{requesting,pending,uploaded,on_way,bond_sent,bond_received,arrived,late_shipments,cancelled}
class FilterChangeShipmentStatusScreen2 extends StatefulWidget{
  // int id;
  // String status;
   Orders2 shipmentCategoryList;

  FilterChangeShipmentStatusScreen2({required this.shipmentCategoryList,});

  @override
  State<StatefulWidget> createState() {
    return _FilterChangeShipmentStatusScreen2();
  }
}
class _FilterChangeShipmentStatusScreen2 extends State<FilterChangeShipmentStatusScreen2>{
  // String status;
  dateGroup? date;
  // int id;
  var lang="";
  _FilterChangeShipmentStatusScreen2();
  final updateStatusController=Get.put(UpdateStatusController());

  @override
  void initState(){
    getStatus();
    super.initState();
    getLang2();
  }

   getLang2()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lang= prefs.getString('lang')!;
      print("lang"+lang.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15,left: 15,top: 10),
      child: Directionality(
        textDirection: lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBar(),
              SingleChildScrollView(child: FilterContainer(context)),
            ],
          ),
        ),
      ),
    );
  }

  getStatus(){
    switch(widget.shipmentCategoryList.status){
      case "requesting":
        date=dateGroup.requesting;
        break;
      case "pending":
        date=dateGroup.pending;
        break;
      case "uploaded":
        date=dateGroup.uploaded;
        break;
      case "on_way":
        date=dateGroup.on_way;
        break;
      case "bond_sent":
        date=dateGroup.bond_sent;
        break;
      case "bond_received":
        date=dateGroup.bond_received;
        break;
      case "arrived":
        date=dateGroup.arrived;
        break;
      case "late_shipments":
        date=dateGroup.late_shipments;
        break;
      case "cancelled":
        date=dateGroup.cancelled;
        break;
    }
  }

  Widget CustomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 60,
            height: 5,
            color: MyColors.Dark6,
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 40,
          child: Stack(
            children: [
              Positioned(
                left: -10,
                child: IconButton(
                    icon: Icon(Icons.close),
                    color: MyColors.Dark3,
                    onPressed:(){
                      Navigator.pop(context);
                    }
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Center(
                  child: Text("${getLang(context, "Change_shipment_status")}",
                    style: TextStyle(fontSize: 18,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.Dark1,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 2,
            color: MyColors.Dark6,
            margin: EdgeInsets.only(top: 5),),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget FilterContainer(BuildContext context){
    return Column(
      children: [
        Filter(),
        ButtonSave()
      ],
    );
  }

  Widget Filter(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${getLang(context, "Choose_status_of_new_shipment")}",
          style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
          textAlign: TextAlign.start,
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "requesting")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.requesting,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "loading")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.pending,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "uploaded")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.uploaded,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "on_way")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.on_way,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "arrived")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.arrived,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "bond_sent")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.bond_sent,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "bond_received")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.bond_received,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        RadioListTile(
          activeColor: MyColors.MAINCOLORS,
          contentPadding: EdgeInsets.all(0),
          title: Text("${getLang(context, "late_shipments")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
          value: dateGroup.late_shipments,
          groupValue: date,
          onChanged: (dateGroup? val){
            setState(() {
              date = val!;
            });
          },
        ),
        // RadioListTile(
        //   activeColor: MyColors.MAINCOLORS,
        //   contentPadding: EdgeInsets.all(0),
        //   title: Text("${getLang(context, "shipment_cancellation")}",style: TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark1)),
        //   value: dateGroup.cancelled,
        //   groupValue: date,
        //   onChanged: (dateGroup? val){
        //     setState(() {
        //       date = val!;
        //     });
        //   },
        // ),
      ],
    );
  }

  Widget ButtonSave(){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        backgroundColor: MyColors.MAINCOLORS,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 60,
      child: TextButton(
        style: flatButtonStyle ,
        onPressed: (){
          updateStatusController.status==date!.name.toString();
            updateStatusController.UpdateStatus2(context,widget.shipmentCategoryList.id!,date!.name.toString());
        },
        child: Text("${getLang(context, "apply")}",
          style: TextStyle(fontSize: 16,fontFamily: 'din_next_arabic_bold',fontWeight: FontWeight.w700,color: MyColors.DarkWHITE),),
      ),
    );
  }

}