import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../business/cityController/CityController.dart';
import '../../../../../business/driverController/DriverController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';

class DeleteDriverScreen extends StatefulWidget{
  int id;
  var token;

  DeleteDriverScreen({required this.id,required this.token});

  @override
  State<StatefulWidget> createState() {
    return _DeleteDriverScreen();
  }
}

class _DeleteDriverScreen extends State<DeleteDriverScreen>{
  final driverController=Get.put(DriverController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: driverController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SvgPicture.asset('assets/delete_dialog_img.svg',),
            ),
            const SizedBox(height: 10,),
            Text("${getLang(context, 'confirm_deletion')}",
              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: MyColors.Dark1,fontFamily: 'din_next_arabic_bold'),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            Text("${getLang(context, 'Do_you_want_to_confirm_the_deletion_driver')}",
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.Dark2,fontFamily: 'din_next_arabic_regulare'),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DialogButton(
                    height: 53,
                    onPressed: () => {
                      driverController.delete(context,widget.token)
                    },
                    color: MyColors.SideRed,
                    child: Text(
                      "${getLang(context, 'delete')}",
                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
                    ),
                  ),
                ),
                Expanded(
                  child: DialogButton(
                    height: 53,
                    onPressed: () => Navigator.pop(context),
                    color: MyColors.Secondry_Color,
                    child: Text(
                      "${getLang(context, 'cancel')}",
                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
                    ),

                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}