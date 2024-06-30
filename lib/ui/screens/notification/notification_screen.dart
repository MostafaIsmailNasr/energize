import 'package:energize_flutter/conustant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../business/notificationController/NotificationController.dart';
import '../../../conustant/AppLocale.dart';
import '../../widget_Items_list/NotificationItem.dart';


class NotificationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen>{
  final notificationController=Get.put(NotificationController());
  @override
  void initState() {
    notificationController.getNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            iconSize:20,
          onPressed: (){
              Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back_ios,color: MyColors.Dark1)
        ),
        title: Text(
          "${getLang(context, "notification")}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'din_next_arabic_medium',
              fontWeight: FontWeight.w500,
              color: MyColors.Dark1),
          textAlign: TextAlign.start,
        ),
        backgroundColor: MyColors.DarkWHITE,
      ),
          body: Obx(() => !notificationController.isLoading.value?
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: NotificationList(),

          ):Center(child: CircularProgressIndicator(color: MyColors.MAINCOLORS))),
        )
    );
  }


  Widget NotificationList(){
      if (notificationController.allNotifications.isNotEmpty) {
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: notificationController.allNotifications.length,
            itemBuilder: (context, int index) {
              return Item(
                  notifi: notificationController.allNotifications[index]);
            }
        );
      } else {
        return emptyNotification();
      }
  }
}

class emptyNotification extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset('assets/error_img.svg'),
          SizedBox(height: 10,),
          Text("${getLang(context, "there_are_no_notifi")}",
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}