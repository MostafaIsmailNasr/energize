import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../business/cityController/CityController.dart';
import '../../../../../conustant/AppLocale.dart';
import '../../../../../conustant/my_colors.dart';

class DeleteScreen extends StatefulWidget{
  int id;

  DeleteScreen({required this.id});

  @override
  State<StatefulWidget> createState() {
    return _DeleteScreen();
  }
}

class _DeleteScreen extends State<DeleteScreen>{
  final cityController=Get.put(CityController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
          textDirection: cityController.lang.contains("en")?TextDirection.ltr:TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SvgPicture.asset('assets/delete_dialog_img.svg',),
              ),
              const SizedBox(height: 10,),
              Text("${getLang(context, 'confirm_deletion')}",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: MyColors.Dark1,fontFamily: 'din_next_arabic_bold'),
              textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              Text("${getLang(context, 'Do_you_want_to_confirm_the_deletion_city')}",
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: MyColors.Dark2,fontFamily: 'din_next_arabic_regulare'),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DialogButton(
                      height: 53,
                      child: Text(
                        "${getLang(context, 'delete')}",
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
                      ),
                      onPressed: () => {
                          cityController.deleteCity(widget.id!,context)
                      },
                      color: MyColors.SideRed,
                    ),
                  ),
                  Expanded(
                    child: DialogButton(
                      height: 53,
                      child: Text(
                        "${getLang(context, 'cancel')}",
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: MyColors.DarkWHITE,fontFamily: 'din_next_arabic_bold'),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: MyColors.Secondry_Color,

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