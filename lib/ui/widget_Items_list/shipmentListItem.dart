import 'dart:io';

import 'package:energize_flutter/ui/screens/Add_payload/add_payload_screen.dart';
import 'package:energize_flutter/ui/screens/filters/home_filter/choose_delegate_filter/choose_delegate_filter_screen.dart';
import 'package:energize_flutter/ui/screens/notes/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business/categoryDetailsController/CategoryDetailsController.dart';
import '../../business/shipmentCategoryDetailsController/ShipmentCategoryDetailsController.dart';
import '../../business/updateStatusController/updateStatusController.dart';
import '../../conustant/AppLocale.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/shipmentCategoryDetailsModel/ShipmentCategoryDetailsResponse.dart';
import '../screens/Add_payload/choose_driver/choose_driver_screen.dart';
import '../screens/filters/filter_change_shipment_status/filter_change_shipment_status_screen.dart';
import '../screens/filters/filter_change_shipment_status/filter_change_shipment_status_screen2.dart';
import '../screens/filters/home_filter/choose_driver_filter/choose_driver_filter_screen.dart';
import '../screens/shipment_details/shipment_details_screen.dart';

class ShipmentListItem extends StatelessWidget{
  String title;
  final Orders2 shipmentCategoryList;
  final shipmentCategoryController=Get.put(ShipmentCategoryDetailsController());
  final updateStatusController=Get.put(UpdateStatusController());
  final shipmentDetailsController=Get.put(CategoryDetailsController());

  ShipmentListItem({required this.shipmentCategoryList,required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("id", shipmentCategoryList.id!);
        prefs.setString("tittle", title!);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //       return ShipmentDetailsScreen();
        //     }));
        Navigator.pushNamed(context, '/shipment_details_screen',);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsetsDirectional.all(8),
        margin: EdgeInsetsDirectional.only(start: 15,end: 15,top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.DarkWHITE,
            boxShadow: const [
              BoxShadow(
                color: MyColors.Dark5,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  margin: EdgeInsets.only(bottom: 60),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: MyColors.Dark6),
                  child: Center(
                      child: SvgPicture.asset('assets/truck_fast.svg', width: 24, height: 24,)
                  ),
                ),
                const SizedBox(width: 2,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Container(
                                 width: 150,
                                 child: Text(
                                   shipmentCategoryList.userName ?? "",
                                   style: const TextStyle(
                                     fontSize: 14,
                                     fontFamily: 'din_next_arabic_medium',
                                     fontWeight: FontWeight.w500,
                                     color: MyColors.Dark1,
                                   ),maxLines: 2,
                                 ),
                               ),
                                const SizedBox(width: 20,),
                              InkWell(
                                  onTap: (){
                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       return NotesScreen(orderId: shipmentCategoryList.id,);
                                    //     }));
                                    Navigator.pushNamed(context, '/notes_screen',arguments: shipmentCategoryList.id);
                                  },
                                  child: Icon(Icons.event_note,color: MyColors.MAINCOLORS,)),
                              const SizedBox(width: 5,),
                              shipmentCategoryList.status=="cancelled"?Container():InkWell(
                                  onTap: (){
                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       return AddPayloadScreen(fromWhere: "edite",shipmentCategoryList:shipmentCategoryList);
                                    //     }));

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return AddPayloadScreen(fromWhere: "edite",shipmentCategoryList:shipmentCategoryList);
                                        }));
                                  },
                                  child: Icon(Icons.edit,color: MyColors.MAINCOLORS,)),
                              const SizedBox(width: 5,),
                              shipmentCategoryList.status=="cancelled"?Container(): InkWell(
                                  onTap: (){
                                    _onAlertButtonsPressed(context);
                                  },
                                  child: const Icon(Icons.delete,color: MyColors.MAINCOLORS,)),
                            ]),
                      SizedBox(
                        width: 120,
                        child: Text((shipmentCategoryList.delegateName??""),
                          style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text((shipmentCategoryList.branchName??""),
                          style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text((shipmentCategoryList.driverName??""),
                          style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_medium',fontWeight: FontWeight.w500,color: MyColors.Dark1,),
                        ),
                      ),
                      // Text(shipmentCategoryList.userMobile??"",
                      //   style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                      // ),
                      Row(
                        children: [
                          Text(shipmentCategoryList.graduationStatement??"",
                            style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),),
                          const SizedBox(width: 100,),
                          Text(shipmentCategoryList.createdAt!,maxLines: 2,
                            style: const TextStyle(fontSize: 12,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                          ),
                        ],
                      ),
                      Text("${getLang(context, "car_number")} ${shipmentCategoryList.carNumber}"??"",
                        style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          SvgPicture.asset('assets/clock.svg'),
                          Text(shipmentCategoryList.differenceDate!,
                            style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/direct_right.svg'),
                                SizedBox(
                                  width: 150,
                                  child: Text("From ${shipmentCategoryList.startAreaName!} To ${shipmentCategoryList.reachAreaName!}",
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.Dark2,),
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
              ],
            ),
            shipmentCategoryList.status!="bond_sent"?
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        whatsapp();
                      },
                      icon: SvgPicture.asset('assets/whats.svg')),
                  IconButton(
                      onPressed: () async {
                        var phone=shipmentCategoryList.driverMobile.toString();
                        _makePhoneCall('tel:$phone');
                      },
                      icon: SvgPicture.asset('assets/phone.svg')),
                ],
              ),
            ):Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        uploadImage(ImageSource.gallery,context);
                      },
                      icon: SvgPicture.asset('assets/upload_image.svg')),
                  IconButton(
                      onPressed: () {
                        whatsapp();
                      },
                      icon: SvgPicture.asset('assets/whats.svg')),
                  IconButton(
                      onPressed: () async {
                        var phone=shipmentCategoryList.driverMobile.toString();
                        _makePhoneCall('tel:$phone');
                      },
                      icon: SvgPicture.asset('assets/phone.svg')),
                ],
              ),
            ),
            Container(
              child: dialogs(context),
            ),
          ],
        ),

      ),
    );
  }

  Widget dialogs(BuildContext context){
    return Row(
      children: [
        //const SizedBox(height: 15,),
        (shipmentCategoryController.role=="delegate"
            ||shipmentCategoryController.role=="admin"
            ||shipmentCategoryController.role=="driver")?
        changeStatusButton(context):Container(width: 5,),
        (shipmentCategoryController.role=="admin"&&shipmentCategoryController.statuse!="cancelled")?
        Expanded(
          child: GestureDetector(
            onTap: ()async{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt("IdOrder", shipmentCategoryList.id!);
              // ignore: use_build_context_synchronously
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: MyColors.DarkWHITE,
                  builder: (BuildContext context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ChooseDelegateFilterScreen(FromWhere: "fromCategoriesStatus")));
            },
            child: Text("${getLang(context, "change_delegate")}",
              style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.MAINCOLORS,),
            ),
          ),
        ):Container(width: 5,),
        const SizedBox(width: 5,),
        ((shipmentCategoryController.role=="admin"||shipmentCategoryController.role=="delegate")
            &&shipmentCategoryController.statuse!="cancelled")?
        Expanded(
          child: GestureDetector(
            onTap: ()async{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt("IdOrder", shipmentCategoryList.id!);
              // ignore: use_build_context_synchronously
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: MyColors.DarkWHITE,
                  builder: (BuildContext context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ChooseDriverFilterScreen(FromWhere: "fromCategoriesStatus")));
            },
            child: Text("${getLang(context, "change_driver")}",
              style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.MAINCOLORS,),
            ),
          ),
        ):Container(width: 5,),

      ],
    );
  }

  changeStatusButton(BuildContext context){
    print("ccv"+shipmentCategoryController.userNameId.toString());
    if(shipmentCategoryController.statuse=="bond_received"
    ||(shipmentCategoryController.statuse=="cancelled"&&shipmentCategoryController.userNameId!=381)){
      return Container(width: 5,);
    }else{
      return Expanded(
        child: GestureDetector(
          onTap: (){
            if(shipmentCategoryList.driverName!=null&&shipmentCategoryList.driverId!=null
                &&shipmentCategoryList.graduationStatement!=null&&shipmentCategoryList.purchasePrice!=null
                &&shipmentCategoryList.salePrice!=null&&shipmentCategoryList.carNumber!=null
                &&shipmentCategoryList.delegateName!=null){
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (BuildContext context)=>DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.9,
                      minChildSize: 0.32,
                      maxChildSize: 0.9,
                      builder: (BuildContext context, ScrollController scrollController)=> SingleChildScrollView(
                        controller:scrollController,
                        child: FilterChangeShipmentStatusScreen2(shipmentCategoryList: shipmentCategoryList),
                      )
                  )

              );
            }
            else{
              ScaffoldMessenger.of(context!).showSnackBar(
                SnackBar(
                  content: Text("${getLang(context!, 'please_complete_data')}"),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.red,
                ),
              );
            }

          },
          child: Text("${getLang(context, "change_status")}",
            style: const TextStyle(fontSize: 14,fontFamily: 'din_next_arabic_regulare',fontWeight: FontWeight.w400,color: MyColors.MAINCOLORS,),
          ),
        ),
      );

    }
  }

  whatsapp()async{
    var phone2= "+966" + shipmentCategoryList.driverMobile.toString();
    var url = 'https://api.whatsapp.com/send?phone=$phone2';
    var iosUrl = "https://wa.me/$phone2";
    if(Platform.isIOS){
      await launchUrl(Uri.parse(iosUrl));
    }
    else{
       await launch(url);
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _onAlertButtonsPressed(context,) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/delete_dialog_img.svg',),
      title: "${getLang(context, 'confirm_deletion')}",
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: MyColors.Dark1,fontFamily: 'din_next_arabic_bold'),
        descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.Dark2,fontFamily: 'din_next_arabic_regulare'),
      ),
      desc: "${getLang(context, 'Do_you_want_to_confirm_the_deletion_shipment')}",
      buttons: [
        DialogButton(
          height: 53,
          child: Text(
            "${getLang(context, 'delete')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
          onPressed: () => {
          updateStatusController.UpdateStatus2(context,shipmentCategoryList.id!,"cancelled")
        },
          color: MyColors.SideRed,
        ),
        DialogButton(
          height: 53,
          child: Text(
            "${getLang(context, 'cancel')}",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
          ),
          onPressed: () => Navigator.pop(context),
          color: MyColors.Secondry_Color,
        )
      ],
    ).show();
  }

  void uploadImage(ImageSource source, BuildContext context)async{
    var pickedImage=await ImagePicker().pickImage(source: source);
    if(pickedImage?.path!=null){
      shipmentDetailsController.boundImg=File(pickedImage!.path);
      shipmentDetailsController.uploadShipmentImg(shipmentCategoryList.id!,context);
    }
  }


}